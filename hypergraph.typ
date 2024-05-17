#import "/assignment/functions.typ": *
#import "@preview/physica:0.9.3": *

#set text(lang: "jp")
#set text(font: "Yu Mincho",12pt)
#show emph: set text(font: "Yu Mincho")
#show strong: set text(font: "Yu Mincho", fill: red)

#let title1 ="hypergraphについての補足"

#set par(
  justify: true,
  leading: 0.6em,
)
#set list(indent: 0.5em)
#set enum(numbering: "i)")
#set heading(numbering: "1.")
// \
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

#theorem-number.step()

#let comb(a,b) = $vec(#a,#b)$
#let Set = $bold("Set")$
#let power(A) = $frak(P)(#A)$

#show "、": "，"
#show "。": "．"

// 先頭字下げ
#show heading: it =>  {
    it
    par(text(size:0.5em, ""))
}

#let indentspace = 1em
#let i = h(indentspace)

#big_title(emph(title1))
#align(center,[柏原 功誠＠理学部1回])

hypergraphの概念は @関真一朗グリーン において導入されているが、もう少し良い定式化があるのではないかと考えた。ここにその一端をお見せしよう。
= 準備

#i $Set$ を*有限*集合全体が成す圏(集まり)とし (通常の定義とは*赤字*の部分が異なる)、$power(V)$ を$V$の部分集合全体の集合とする。また、$V in Set, space r in NN$ に対して、$V$の濃度(元の個数)が $r$ である部分集合全体を
$
comb(V,r) := {e in power(V) | "#"e = r}
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
  頂点集合$V in Set$ と 辺集合$E subset comb(V,2)$ の組 $ G = (V,E) $ を*graph*という。
])

#theorem(title: "三角形", kind: "例",[
  三角形 $K_3$ は #hide[頂点集合 と 辺集合$E subset comb(V,2)$ の組]
  $ V={1,2,3}, space E={{1,2},{2,3},{3,1}} $
  とすることで実現できる。
])

#i 辺全体を部分集合族で定めたことにより、同じ頂点をもつ辺は自動的に同一視されることに注意してほしい(結果的に多重辺は無くなっている)。

#i 以上の定義においては $E$ は $comb(V,2)$ の部分集合、即ち辺集合の各元 $e$ は2点集合であった。ここを $E subset power(V)$ まで緩める、つまり辺 $e$ が2点以上のものを考えることで、hypergraphの定義を得る。


#theorem(title: "hypergraph", kind: "定義",[
  頂点集合$V in Set$ と 辺集合$E subset power(V)$ の組 $ G = (V,E) $ を*hypergraph*という。
]) 

#i @関真一朗グリーン では $E subset power(V) backslash {emptyset}$ としているのは、空グラフ $(V,emptyset)$ と $(V,{emptyset})$ が紛らわしいからであろう(一般に、$emptyset$と${emptyset}$は集合として異なる)。
だだ、一般論を展開する上では上記のように定義したほうが自然であると考えた。
筆者はこの違いがもたらす影響を全ては把握できていない (以降に出てくる具体例は全て @関真一朗グリーン の定義を満たすので安心してほしい)。

= $k$#h(0.2em)部#h(0.2em)$r dash.fig$graph (その一)


#pagebreak()

#bibliography("hypergraph.bib")