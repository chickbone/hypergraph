#let qed = [
  #align(end,
   rect(width: 9pt,height: 9pt,)
  )
  #v(10pt)
]

#let numbered_eq(content) = math.equation(
  block: true,
  numbering: "(1)",
  content,
)

#let big_title(content) = [
  #v(10pt)
  #align(center, text(17pt)[
    #content
  ])
  #v(15pt)
]