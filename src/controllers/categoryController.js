app.get('/categories', async (req, res) => {
  const categories = await getAllCategories();
  const title = 'Service Project Categories';
  res.render('categories', { title, categories });
});
