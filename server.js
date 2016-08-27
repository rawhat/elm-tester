var koa = require('koa');
var app = new koa();

var router = require('koa-router')();

var views = require('koa-views');

var serve = require('koa-static');

app.use(serve('./static'));

app.use(views(__dirname + '/views', {
  slm: 'slim'
}));

router.get('/', async (ctx) => {
  await ctx.render('index.slm');
});

app.use(router.allowedMethods());
app.use(router.routes());

app.listen(3000);
