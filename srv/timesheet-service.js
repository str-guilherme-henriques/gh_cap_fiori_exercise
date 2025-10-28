module.exports = srv => {

  // Filtrar automaticamente apenas registos ativos
  srv.before('READ', '*', (req) => {
    if (!req.query.SELECT.where) req.query.where('isActive =', true);
    });

  // Validar que o colaborador não ultrapassa 8h por dia
  srv.before('CREATE', 'WorkEntries', async (req) => {
    const { employee_ID, date, hours } = req.data;

    const existing = await SELECT.one.from('innova.tech.WorkEntry')
      .columns('sum(hours) as total')
      .where({ employee_ID, date });

    const totalHours = (existing?.total || 0) + hours;

    if (totalHours > 8) {
      req.error(400, 'dailyHourLimitExceeded', [existing?.total || 0]);
    }
  });

  // Somar horas semanais por projeto e colaborador
  srv.on('getWeeklySummary', async (req) => {
    const { employee_ID, weekStart, weekEnd } = req.data;

    const results = await SELECT.from('innova.tech.WorkEntry')
      .columns('project_ID', 'sum(hours) as total')
      .where({ employee_ID })
      .and(`date between '${weekStart}' and '${weekEnd}'`)
      .groupBy('project_ID');

    return results;
  });

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
