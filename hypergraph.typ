#import "/functions.typ": *
#import "@preview/cetz:0.2.2"
#import "@preview/fletcher:0.4.4"
#import "@preview/gentle-clues:0.8.0": *
#import "@preview/physica:0.9.3": *

#set text(lang: "jp")
#set text(font: "Harano Aji Mincho",12pt)
#show emph: set text(font: "Harano Aji Mincho",weight: "bold")
#show strong: set text(font: "Harano Aji Mincho",weight: "bold",)

#let title1 ="hypergraphについての補足"

#set par(
  justify: true,
  leading: 0.6em,
)
#set list(indent: 0.5em)
#set enum(numbering: "i)")
#set heading(numbering: "1.")
#set figure(supplement: "図")

#set page(
  paper: "a4",
  header: align(right)[
      #title1
  ],
  numbering: "1",
)

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

#let comb(a,b) =$vec(#a,#b)$
#let Set =$bold("Set")$
#let Grph =$bold("Grph")$
#let rGrph(r) =$#r thin hyph.nobreak thin bold("Grph")$
#let power(A) =$frak(P)(#A)$
#let rgraph(r) = [$#r thin hyph.nobreak$graph]
#let krgraph(k,r) = [$#k$部$#r thin hyph.nobreak$graph]

#show "、": "，"
#show "。": "．"

// 先頭字下げ
#show heading: it =>  {
    theorem-number.update(1)
    it
    par(text(size:0.5em, ""))
}
#show math.equation: it => {
  h(0.17em, weak: true)
  it
  h(0.17em, weak: true)
}

#let indentspace = 1em
#let i = h(indentspace)

// body
#big_title(emph(title1))
#align(center,[
  柏原 功誠\@理学部1回

  #text(10pt)[
    $dash.em$概要$dash.em$\
    hypergraphの概念は @関真一朗グリーン において導入されているが、もう少し良い定式化があるのではないかと考えた。ここにその一端をお見せしよう。
  ]
])

#outline()

= 準備

#i$Set$を*有限*集合全体が成す圏(集まり)とし (通常の定義とは*太字*の部分が異なる)、$power(V)$を$V in Set$の部分集合全体の集合とする。
また、$V in Set, space r in NN$に対して、$V$の濃度(元の個数)が$r$である部分集合全体を
$
  comb(V,r) := {e in power(V) | hash e = r}
$
とする。

#i 部分集合族$E subset power(V)$と$phi: V -> V'$に対して、$phi$による$E$の像を
$
  phi(E) := {phi(e) | e in E} subset power(V')
$
と定める。

= hypergraphの定義

#i hypergraphとは普通の(2-)graphの拡張である。ここではhypergraphを定義する前に通常のgraphが頂点集合とその部分集合族の組として表されることを見よう。\
ただし、ここで言うgraphとは単純無向有限graph、即ち多重辺を許さず頂点集合が有限なものに限っていることに注意されたい。

#theorem(title: "graph", kind: "定義",[
  頂点集合$thin V in Set$と 辺集合$E subset comb(V,2)$の組$ G = (V,E) $を*graph*という。
])

#theorem(title: "三角形", kind: "例",[
  三角形$K_3$は #hide[頂点集合 と 辺集合$E subset comb(V,2)$の組]
  $ V={1,2,3}, space E={{1,2},{2,3},{3,1}} $
  とすることで実現できる。
])

#figure(
  cetz.canvas({
  import cetz.draw: *
//  intersections("i", {
//    line((-1,0),(0,1.5))
//    line((-1,0),(1,0))
//    line((1,0),(0,1.5))
//  })
//  for-each-anchor("i", (name) => {
//    circle("i." + name, radius: .1, fill: blue)
//  })
    circle((-1,0), radius: 0.1, fill: black, name: "a")
    circle((1,0), radius: 0.1, fill: black, name: "b")
    circle((0,1.5), radius: 0.1, fill: black, name: "c")
    line("a","b")
    line("b","c")
    line("a","c")
  }),
  caption: [三角形$K_3$の一例]
)

#i 辺全体を部分集合族で定めたことにより、同じ頂点をもつ辺は自動的に同一視されることに注意してほしい(結果的に多重辺は無くなっている)。

#i 以上の定義においては$E$は$comb(V,2)$の部分集合、即ち辺集合の各元$e$は2点集合であった。ここを$E subset power(V)$まで緩める、つまり辺$e$が2点以上のものを考えることで、hypergraphの定義を得る。

#theorem(title: "hypergraph", kind: "定義",[
  頂点集合$thin V in Set$と 辺集合$E subset power(V)$の組
  $ G = (V,E) $
  を*hypergraph*という。
  このとき、$E$の元$e$を辺と呼ぶ。
])

#figure(
  image("Hypergraph.gif", width: 50%),
  caption: [hypergraphの例 (Wikipedia "hypergraph" より)],
)

#warning[
  @関真一朗グリーン では$E subset power(V) backslash {emptyset}$と定義しているのは、空グラフ$(V,emptyset)$と$(V,{emptyset})$が紛らわしいからであろう
  (一般に、$emptyset$と${emptyset}$は集合として異なる)。
  だだ、一般論を展開する上では上記のような定義を採用したほうが自然であると考えた。
  この違いがもたらす影響を筆者は全て把握できてはいない (以降に出てくる具体例は全て @関真一朗グリーン の定義を満たすので安心してほしい)。
]

= #krgraph($k$,$r$) (その一)

#i この章では、厳密な定義は後回しで#krgraph($k$,$r$)を理解することを目標とする。特に、重要な例として、#krgraph(3,2) を取り上げる。

#i まず、$r in NN$に対して #rgraph($r$) とは各辺の濃度が$r$であるhypergraphのことである:

#theorem(title: "hypergraph", kind: "定義",[
  頂点集合$thin V in Set$と 辺集合$E subset comb(V,r)$の組$ G = (V,E) $を#emph(rgraph($bold(r)$))という。
  このとき、$E$の元$e$を辺と呼ぶ。
])

#figure(
  cetz.canvas({
    import cetz.draw: *
    for (x,y,n,d) in (
      (-1,0,  "a", "north"),
      (1,0,   "b", "north"),
      (0,1.5, "c", "south"),
      (2,1.5, "d", "south"),
    ) {
      circle((x,y), radius: .1,fill: black, name: n)
      content(n, n, padding: .2, anchor: d)
    }
    line("a", "b", "c", "a", fill: blue,stroke: none)
    line("b", "d", "c", close: true, fill: red,stroke: none)
  }),
  caption: [#rgraph(3)$V = {a,b,c,d}, space E = {e_1 = {a,b,c}, e_2 = {b,c,d}}$]
)

この定義において、通常のgraphとは#rgraph(2)のことである。

#pagebreak()

#bibliography("hypergraph.bib", title: "参考文献")