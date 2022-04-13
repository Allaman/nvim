require("luasnip.loaders.from_lua").lazy_load()

return {
	parse("gmail", "michaeljohannpeter@gmail.com"),
	parse("rootknecht", "allaman@rootknecht.net"),
	parse("mfg", "Mit freundlichen Grüßen\nMichael Peter"),
	parse("sehrg", "Sehr geehrte Damen und Herren, \n\n"),
	s("date", p(os.date, "%Y-%m-%d")),
	s("time", p(os.date, "%H:%M")),
}
