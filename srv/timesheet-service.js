module.exports = srv => {

  // Lista de feriados (pode ser movida para uma configuração externa)
  const holidays = [
    '2025-01-01', // Ano Novo
    '2025-02-13', // Carnaval
    '2025-03-29', // Sexta-feira Santa
    '2025-03-31', // Páscoa
    '2025-04-25', // Dia da Liberdade
    '2025-05-01', // Dia do Trabalhador
    '2025-05-30', // Corpo de Deus
    '2025-06-10', // Dia de Portugal
    '2025-08-15', // Assunção de Nossa Senhora
    '2025-10-05', // Implantação da República
    '2025-11-01', // Dia de Todos os Santos
    '2025-12-01', // Restauração da Independência
    '2025-12-08', // Imaculada Conceição
    '2025-12-25', // Natal
  ];

  // Validações na criação de um registo de trabalho
  srv.before('CREATE', 'WorkEntries', async (req) => {
    const { employee_ID, project_ID, date, hours } = req.data;

    // 1. Validar que o colaborador não ultrapassa 8h por dia
    // (Considera todos os registos do dia, mesmo os de outros projetos)
    const existing = await SELECT.one.from('innova.tech.WorkEntry')
      .columns('sum(hours) as total')
      .where({ employee_ID, date });

    const totalHours = (existing?.total || 0) + hours;

    if (totalHours > 8) {
      req.error(400, 'dailyHourLimitExceeded', [existing?.total || 0]);
    }

    // 2. Validar que a data é um dia útil (não é fim de semana nem feriado)
    const entryDate = new Date(date);
    const dayOfWeek = entryDate.getUTCDay(); // 0=Domingo, 6=Sábado

    if (dayOfWeek === 0 || dayOfWeek === 6 || holidays.includes(date)) {
      req.error(400, 'workEntryOnNonWorkingDay');
    }

    // 3. Validar se já existe um registo para o mesmo colaborador, projeto e data
    const duplicate = await SELECT.one.from('innova.tech.WorkEntry').where({ employee_ID, project_ID, date, isActive: true });

    if (duplicate) {
      req.error(400, 'duplicateWorkEntry');
    }

  });

  // Função auxiliar para calcular o total de horas semanais
  const getWeeklyHoursFor = async (req, filterField, messageTemplate) => {
    const { ID } = req.params[0];
    const today = new Date();
    const dayOfWeek = today.getUTCDay(); // 0=Domingo, 1=Segunda, ...

    // Define o início da semana como Segunda-feira (subtrai os dias passados desde segunda)
    const weekStart = new Date(today);
    const dayOfMonth = weekStart.getUTCDate();
    const dayAdjustment = dayOfWeek === 0 ? 6 : dayOfWeek - 1; // Se for Domingo (0), volta 6 dias
    weekStart.setUTCDate(dayOfMonth - dayAdjustment);

    // Formata as datas para YYYY-MM-DD
    const weekStartDate = weekStart.toISOString().slice(0, 10);
    const todayDate = today.toISOString().slice(0, 10);

    // Constrói a condição de filtro dinamicamente
    const whereCondition = { [filterField]: ID };

    // Soma as horas na semana corrente
    const result = await SELECT.one.from('innova.tech.WorkEntry')
      .columns('sum(hours) as totalHours')
      .where(whereCondition)
      .and(`date between '${weekStartDate}' and '${todayDate}'`);

    const totalHours = result?.totalHours || 0;

    // Retorna uma mensagem de sucesso para o utilizador
    const message = messageTemplate.replace('{0}', totalHours);
    req.notify(message);
    return message;
  };

  // Implementação da ação getWeeklyHoursSummary para Employees e Projects
  srv.on('getWeeklyHoursSummary', 'Employees', (req) => getWeeklyHoursFor(req, 'employee_ID', 'O colaborador registou um total de {0} horas na semana corrente.'));
  srv.on('getWeeklyHoursSummary', 'Projects', (req) => getWeeklyHoursFor(req, 'project_ID', 'O projeto consumiu um total de {0} horas na semana corrente.'));

  // DELETE lógico em todas as entidades
  for (const entity of ['Employees', 'Projects', 'WorkEntries']) {
    srv.on('DELETE', entity, async (req) => {
      const { ID } = req.params[0];
      const singular = (entity === 'WorkEntries') ? 'WorkEntry' : entity.slice(0, -1);
      const table = `innova.tech.${singular}`;
      
      const affected = await UPDATE(table).set({ isActive: false }).where({ ID });
      
      if (affected === 0) {
        req.error(404, `Registo ${ID} não encontrado ou já inativo.`);
      }

      return affected;
    });
  }

};
