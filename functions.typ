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

#let theorem-number = counter("theorem-number")

#let theorem(title: none, kind: "定理", body) = {
  let head_num = context(counter(heading).get()).first()
  let thm_num = theorem-number.display()
  let title-text = {
   if title == none {
     emph[#kind #head_num.#thm_num ]
   }
   else {
     emph[#kind #head_num.#thm_num【#title】]
   }
  }

  box(stroke: (left: 1pt), inset: (left: 5pt, top: 2pt, bottom: 5pt))[
    #title-text #h(0.5em)
    #body
  ]

  theorem-number.step()
}

#let proof(body) = list(marker: "証:")[
  #body
  #qed
]

#let comb(a,b) =$vec(#a,#b)$
#let rGrph(r) =$bold("Grph")_(#r)$
#let power(A) =$frak(P)(#A)$
#let rgraph(r) = [$#r thin hyph.nobreak$graph]
#let krgraph(k,r) = [$#k$部$#r thin hyph.nobreak$graph]