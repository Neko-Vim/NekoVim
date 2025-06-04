local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local f = ls.function_node

ls.add_snippets("javascript", {

	s("ex-app", {
		t({
			"var express = require('express');",
			"var app     = express();",
			"app.get('/', function(req, res){",
			"    res.send('hello');",
			"});",
			"app.set('port', process.env.PORT || 3000);",
			"var server = app.listen(app.get('port'), function() {",
			"  console.log('Express server listening on port ' + server.address().port);",
			"});",
		}),
	}),

	s("app-get", {
		t('app.get("'),
		i(1, "/route"),
		t('", function(req, res){'),
		t({ "", "    res.json({ msg: 'hello' });", "});" }),
	}),

	s("app-all", {
		t('app.all("'),
		i(1, "/secret"),
		t('", function (req, res, next) {'),
		t({ "", "  console.log('Accessing the secret section ...');", "  next(); // pass control to the next handler" }),
		t({ "", "  " }),
		i(2),
		t({ "", "});" }),
	}),

	s("router-get", {
		t('router.get("'),
		i(1, "/route"),
		t('", function(req, res) {'),
		t({ "", "    res.json({ message: 'hello' });", "});" }),
	}),

	s("app-post", {
		t({ 'app.post("/", function (req, res) {' }),
		t({ "", '  res.send("POST request to the homepage");', "});" }),
	}),

	s("app-callbacks", {
		t('app.get("'),
		i(1, "/example/slug"),
		t('", [cb0, cb1, cb2]);'),
	}),

	s("app-route", {
		t('app.route("'),
		i(1, "/entity"),
		t({ '")' }),
		t({ "", "  .get(function(req, res) {" }),
		t({ "    res.send('Get a random entity');", "  })" }),
		t({ "  .post(function(req, res) {" }),
		t({ "    res.send('Add an entity');", "  })" }),
		t({ "  .put(function(req, res) {" }),
		t({ "    res.send('Update the entity');", "  });" }),
	}),

	s("router-crud", {
		t('router.route("'),
		i(1, "/entity"),
		t('")'),
		t({ "", "  .get(function(req, res) { res.json({ message: 'Showing' }); })" }),
		t({ "  .put(function(req, res) { res.json({ message: 'Updated' }); })" }),
		t({ "  .post(function(req, res) { res.json({ message: 'Created' }); })" }),
		t({ "  .delete(function(req, res) { res.json({ message: 'Deleted' }); });" }),
	}),

	s("router-use", {
		t('router.use("'),
		i(1, "/user"),
		t('", function(req, res, next) {'),
		t({ "", "    console.log('Request URL:', req.originalUrl);", "    next();" }),
		t({ "", "}, function (req, res, next) {" }),
		t({ "    console.log('Request Type:', req.method);", "    next();", "});" }),
	}),

	s("app-use", {
		t('app.use("'),
		i(1, "/user"),
		t('", function (req, res, next) {'),
		t({ "", "    console.log('Request Type:', req.method);", "    next();", "});" }),
	}),

	s("app-use-next", {
		t('app.use("'),
		i(1, "/user"),
		t('", function(req, res, next) {'),
		t({ "", "    console.log('Request URL:', req.originalUrl);", "    next();" }),
		t({ "", "}, function (req, res, next) {" }),
		t({ "    console.log('Request Type:', req.method);", "    next();", "});" }),
	}),

	s("app-engine", {
		t('app.engine("html", require("ejs").renderFile);'),
	}),

	s("app-engine-hbs", {
		t({ 'var exphbs = require("express-handlebars");' }),
		t({ "", 'app.engine(".hbs", exphbs({defaultLayout: "single", extname: ".hbs"}));' }),
		t({ "", 'app.set("view engine", ".hbs");' }),
	}),

	s("app-engine-all", {
		t('var engines = require("consolidate");'),
		t({ "", 'app.engine("haml", engines.haml);' }),
		t({ "", 'app.engine("html", engines.hogan);' }),
	}),

	s("app-use-static", {
		t('app.use(express.static("public", '),
		i(1, "options"),
		t("));"),
	}),

	s("app-use-error", {
		t("app.use(function(err, req, res, next) {"),
		t({ "", "    console.error(err.stack);" }),
		t({ "", "    res.status(500).send('Something broke!');", "});" }),
	}),

	s("hb-helper", {
		t({ 'var hbs = require("express-handlebars").create({' }),
		t({ "", "    helpers: {" }),
		t({ "", "        foo: function () { return 'FOO!'; }," }),
		t({ "", "        " }),
		i(1, "bar"),
		t(": function () { "),
		i(2),
		t(" }"),
		t({ "", "    }" }),
		t({ "", "});" }),
	}),

	s("cmd", {
		t({
			"module.exports = {",
			"  info: {",
			'    name: "',
		}),
		i(1, ""),
		t({ '",', '    description: "' }),
		i(2, ""),
		t({ '",', '    category: "' }),
		i(3, ""),
		t({ '",', '    usage: "' }),
		i(4, ""),
		t({ '",', "    perms: [],", "    dev: " }),
		i(5, ""),
		t({ "", "  },", "  run: async (client, message, args) => {" }),
		i(6, ""),
		t({ "  }", "};" }),
	}),
})
