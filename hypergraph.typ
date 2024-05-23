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
#set enum(numbering: "(i)")
#set heading(numbering: "1.")
#set figure(supplement: "図")

#set page(
  paper: "a4",
  header: align(right)[
      #title1
  ],
  numbering: "1",
)

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
  *頂点集合*$thin V in Set$と*辺集合*$E subset power(V)$の組
  $ G = (V,E) $
  を*hypergraph*という。
  このとき、$E$の元$e$を辺と呼ぶ。また、
  $ V(G)=V, space E(G)=E $
  をhypergrphのそれぞれ頂点集合、辺集合を与える対応とする。
])

#figure(
  image("Hypergraph.gif", width: 50%),
  caption: [hypergraphの例 (Wikipedia "hypergraph" より)],
)

#warning[
  @関真一朗グリーン では$E subset power(V) without {emptyset}$と定義しているのは、空グラフ$(V,emptyset)$と$(V,{emptyset})$が紛らわしいからであろう
  (一般に、$emptyset$と${emptyset}$は集合として異なる)。
  だだ、一般論を展開する上では上記のような定義を採用したほうが自然であると考えた。
  この違いがもたらす影響を筆者は全て把握できてはいない (以降に出てくる具体例は全て @関真一朗グリーン の定義を満たすので安心してほしい)。
]

= #krgraph($k$,$r$) (その一)

#i この節では、厳密な定義は後回しで#krgraph($k$,$r$)を理解することを目標とする。特に、重要な例として、#krgraph(3,2) を取り上げる。

#i まず、$r in NN$に対して #rgraph($r$) とは各辺の濃度が$r$であるhypergraphのことである:

#theorem(title: "r-graph", kind: "定義",[
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
  caption: [#rgraph(3) $(V = {a,b,c,d}, space E = {e_1 = {a,b,c},space e_2 = {b,c,d}})$]
) <3graphfig>

特に、通常の意味でのgraphとは#rgraph(2)のことである。
以下、単にgraphといえばhypergraphの事を指し、通常の意味でのgraphは#rgraph(2)と呼んで区別する。

#i では、次にgraphの頂点に"色を塗る"ことを考えよう。ただし、次の規則に従うものとする:
#align(center)[
  彩色の規則: 各辺の頂点は互いに異なる色で塗る。
]
例えば @3graphfig の#rgraph(3)は次のようにして3色に塗り分けられる:

#figure(
  cetz.canvas({
    import cetz.draw: *
    for (x,y,n,d,col) in (
      (-1,0,  "a", "north", red),
      (1,0,   "b", "north", blue),
      (0,1.5, "c", "south", green),
      (2,1.5, "d", "south", red),
    ) {
      circle((x,y), radius: .1,fill: col, stroke: col, name: n)
      content(n, n, padding: .2, anchor: d)
    }
    line("a", "b", "c", "a", fill: luma(200,20%),stroke: none)
    line("b", "d", "c", close: true, fill: luma(200,20%),stroke: none)
  }),
  caption: [@3graphfig の#rgraph(3)の3色を用いた彩色]
)

逆に、色が塗られた頂点集合が与えられたとき、異なる色の頂点を選んで辺を引けば彩色されたgraphが得られる。
(これは @関真一朗グリーン での#krgraph($k$,$r$)データに対応する。)

#figure(
  cetz.canvas({
    import cetz.draw: *
    group(anchor: "east", padding: 1.5,{
    for (x,y,n,col) in (
      (-3,0,  "a1", red),
      (-2.5,0.5,  "a2", red),
      (-1.7,0.2,  "a3", red),
      (-2.7,-0.5,  "a4", red),
      (2,0.2,   "b1", blue),
      (1.5,-0.4,   "b2", blue),
      (0.7,3, "c1", green),
      (0,3.5, "c2", green),
      (-0.7,2.5, "c3", green),
    ) {
      circle((x,y), radius: .1,fill: col, stroke: col, name: n)
    }
    line("a1", "b1",fill: luma(0,70%))
    line("a4", "b1",fill: luma(0,70%))
    line("a3", "b2",fill: luma(0,70%))
    line("b1", "c1",fill: luma(0,70%))
    line("b2", "c2",fill: luma(0,70%))
    line("b2", "c3",fill: luma(0,70%))
    line("a3", "c2",fill: luma(0,70%))
    line("a2", "c3",fill: luma(0,70%))
    })
    line((-1,1.5),(0.5,1.5), mark: (end: "straight"))
    group(anchor: "west", padding: 1.5, {
    for (x,y,n,d,col) in (
      (-1.5,0,"1", "north", red),
      (1.5,0, "2", "north", blue),
      (0,2.5, "3", "south", green),
    ) {
      circle((x,y), radius: .5,fill: col, stroke: col, name: n)
      content(n, n, padding: .6, anchor: d)
    }
      line("1", "2", stroke: 0.2em)
      line("3", "2", stroke: 0.2em)
      line("1", "3", stroke: 0.2em)
    })
  }),
  caption: [#krgraph(3,2)$G$の例]
) <3bu2graph>

ここで、$k$色で彩色可能な#rgraph($r$)ことを#krgraph($k$,$r$)と呼ぶこととする (厳密な定義は後述)。

#i ここまで"彩色"という曖昧な用語を用いてきたが、色を塗るというのは結局のところ頂点集合$V$から色の集合$J$への写像(全射)を与えることと等しい。\
例えば @3bu2graph の#krgraph(3,2)$G$において、$V(G)$から$J=[3]$への写像
$ lambda: V(G) -> J (= [3]) $
は、赤色の点を$1 in J$に、青色の点を$2 in J$に、緑色の点を$3 in J$にそれぞれ対応させる。
このとき、$j space (in J)$色の点全体は$V_j = lambda^(-1)(j)$と表される。

#i ただ、ここまでの議論には致命的な欠陥がある: 彩色の規則が全く反映されていない！！ 特に$lambda: V(G) -> J$ を適当に与えたとき、$lambda$に対応する彩色が規則を満たす保障はどこにもない。以下の節ではこの問題を解決するように#krgraph($k$,$r$)を定義することに捧げられる。基本的なアイデアとしては、
- $J$ をgraph$K_3$と思い、
- $lambda$を "graphの間の写像" $lambda: G -> K_3$とみなす
ことにより達成される。

= graph map, #rgraph($bold(r)$) map

#i 前節で述べたように、この節では "graphの間の写像" graph mapを定義する。

#theorem(title: "graph map", kind: "定義",[
  二つのgraph$G,G'$に対して、$G$から$G'$への*graph map*$ f: G -> G' $とは、
    + 頂点集合の間の写像$space f: V(G) -> V(G') space$であって、
    + 全ての$e in E(G)$に対して、ある$e' in E(G')$が存在して$f(e) subset e'$を満たす 
  もののことを言う。
])

上の条件 (ii) は、式で書くと
$
  forall e in E(G), space exists e' in E(G'), space f(e) subset e'
$
であり、$G$の各辺を$f$で写した像が$G'$のある辺に含まれているということを主張する。

#theorem(kind: "例",[
  
])





#pagebreak()

#bibliography("hypergraph.bib", title: "参考文献")