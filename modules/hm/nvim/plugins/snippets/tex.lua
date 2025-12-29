local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

ls.add_snippets("tex", {

	-- Figure environment
	s("fig", {
		t({ "\\begin{figure}[htbp]", "  \\centering", "  \\includegraphics[width=" }),
		i(1, "\\linewidth"),
		t({ "]{" }),
		i(2, "image"),
		t({ "}", "  \\caption{" }),
		i(3, "caption"),
		t({ "}", "  \\label{fig:" }),
		i(4, "label"),
		t({ "}", "\\end{figure}" }),
	}),

	-- Equation environment
	s("eq", {
		t({ "\\begin{equation}", "  " }),
		i(1),
		t({ "", "\\end{equation}" }),
	}),

	-- Itemize
	s("it", {
		t({ "\\begin{itemize}", "  \\item " }),
		i(1),
		t({ "", "\\end{itemize}" }),
	}),
})
