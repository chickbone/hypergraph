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
#set heading(numbering: "1.1.")
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

#let Set =$bold("Set")$
#let Grph =$bold("Grph")$

// body
#big_title(emph(title1))
#align(center,[
  柏原 功誠\@理学部1回

  #text(10pt)[
    $dash.em$概要$dash.em$\
    hypergraphの概念は @関真一朗グリーン において導入されているが、もう少し良い定式化があるのではないかと考えた。ここにその一端をお見せしよう。
  ]
])

#outline(title: "目次")

= 準備

#i$Set$を*有限*集合全体が成す圏(集まり)とし (通常の定義とは*太字*の部分が異なる)、$power(V)$を$V in Set$の部分集合全体の集合とする。$id_V : V -> V$を恒等写像とする

#i また、$V in Set, space r in NN$に対して、$V$の濃度(元の個数)が$r$である部分集合全体を
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

#i hypergraphとは普通の(2-)graphを拡張した概念である。ここではhypergraphを定義する前に通常のgraphが頂点集合とその部分集合族の組として表されることを見よう。\
ただし、ここで言うgraphとは単純無向有限graph、即ち多重辺を許さず頂点集合が有限なものに限っていることに注意されたい。

#theorem(title: "(2-)graph", kind: "定義",[
  頂点集合$thin V in Set$と 辺集合$E subset comb(V,2)$の組$ G = (V,E) $を*graph*という。
  このとき、$V$の元$v$を頂点、$E$の元$e$を辺と呼ぶ。
])

ここで各$e in E$は2元集合なので、二つの異なる頂点$v,w$を用いて$e={v,w}$と書ける。
この時頂点$v$と$w$に辺が引かれていると考えることで、次のような図が書ける。

#theorem(title: "三角形", kind: "例",[
  三角形$K_3$は #hide[頂点集合 と 辺集合$E subset comb(V,2)$の組]
  $ V=[3]={1,2,3}, space E={{1,2},{2,3},{3,1}} $
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

辺全体を部分集合族で定めたことにより、同じ頂点をもつ辺は自動的に同一視されることに注意してほしい(結果的に多重辺は無くなっている)。

#i 以上の定義においては$E$は$comb(V,2)$の部分集合、即ち辺集合の各元$e$は2元集合であった。ここを$E subset power(V)$まで緩める、つまり辺$e$が2点以上のものを考えることで、hypergraphの定義を得る。

#theorem(title: "hypergraph", kind: "定義",[
  *頂点集合*$thin V in Set$と*辺集合*$E subset power(V)$の組
  $ G = (V,E) $
  を*hypergraph*という。
  このとき、$V$の元$v$を頂点、$E$の元$e$を辺と呼ぶ。また、
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
  このとき、$E$の元$e$は濃度が$r$の$V$の部分集合である。
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
  caption: [#krgraph(3,2)$G_0$の例]
) <3bu2graph>

ここで、$k$色で彩色可能な#rgraph($r$)ことを#krgraph($k$,$r$)と呼ぶこととする (厳密な定義は後述)。

#i ここまで"彩色"という曖昧な用語を用いてきたが、色を塗るというのは結局のところ頂点集合$V$から色の集合$J$への写像(全射)を与えることと等しい。\
例えば @3bu2graph の#krgraph(3,2)$G_0$において、$V(G_0)$から$J=[3]$への写像
$ lambda: V(G_0) -> J (= [3]) $
は、赤色の点を$1 in J$に、青色の点を$2 in J$に、緑色の点を$3 in J$にそれぞれ対応させる。
このとき、$j space (in J)$色の点全体は$V_j = lambda^(-1)(j)$と表される。

#i ただ、ここまでの議論には致命的な欠陥がある: 彩色の規則が全く反映されていない！！ 特に$lambda: V(G_0) -> J$ を適当に与えたとき、$lambda$に対応する彩色が規則を満たす保障はどこにもない。以下の節ではこの問題を解決するように#krgraph($k$,$r$)を定義することに捧げられる。基本的なアイデアとしては、
- $J$ をgraph$K_3$と思い、
- $lambda$を "graphの間の写像" $lambda: G_0 -> K_3$とみなす
ことにより達成される。
#pagebreak()

= graphの間の写像
== graph map

#i 前節で述べたように、この節では "graphの間の写像" graph mapを定義する。


#i graphとは辺集合という構造を持った集合なので、その間の"写像"としては構造を保つ写像を考えたい。素朴に考えれば辺を辺に写すようなものが良いのだろうが、一般の(hyper)graphでは元の個数についての制限がないので、もう少し条件を緩めてみる。つまり、辺を写した像がある辺に含まれていれば良いとする。ここまでの議論をまとめて、以下の定義を得る。

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
であり、$G$の各辺を$f$で写した像が$G'$のある辺に含まれているということを意味する。


#theorem(kind: "例",[
  + @3bu2graph において、$lambda: V(G_0) -> J = V(K_3)$はgraph map$lambda: G_0 -> K_3$となる. 実際、例えば赤色の点から青色の点への辺$e$は、$lambda$によって$K_3$の辺$e'={1,2}$に移る ($lambda(e) subset e'$が成り立つ)。他の色の間の辺も同様であるから、結局$lambda: G_0 -> K_3$はgraph mapとなる。
  + 二つのgraph$G,H(!= emptyset)$について、全ての$G$の頂点をある$H$の頂点$h in H$に移す写像を$ c_h : V(G) -> V(H), space c_h (v) = h space (forall v in V(G)) $ と定める。このとき、任意の$e in E(G)$に対して$c_h (e) = {h}$であるから、「$c_h$がgraph mapとなる」と「$h in e'$なる$e' in E(H)$が存在する」は同値であることがわかる。
  + graph$G$について、$id_(V(G)) : V(G) -> V(G)$は$id_G (e) = e$となるので、明らかにgraph mapとなる。$id_V(G)$を$id_G$と書き、graph$G$の*恒等射*という。一方、一般の写像$f: V(G) -> V(G)$は常にgraph mapになるとは限らない。
])

次の例はgraph mapを考える主な動機の一つである。

#theorem(kind: "例",[
  graph$(X,O_X),(Y,O_Y)$が位相空間となる (位相空間の公理を満たす)とき、$(X,O_X)$から$(Y,O_Y)$へのgraph mapとは即ち*連続写像*のことである。実際
  $
   forall U in O_X, exists V in O_Y, space f(U) subset V\ <==> forall V in O_Y, space f^(-1)(V) in O_X 
  $
  が位相空間の一般論より従う。同様に、graphが(有限)加法族の構造を持つとき、その間のgraph mapとは*可測関数*のことである。
])

graph mapの定義がある意味で"うまくいっている"ことは、次の命題によって保証される:

#theorem(kind: "命題",[
  $F,G,H,L$をgraphとする。
  + graph map$f:F->G,space g:G->H$に対して、その合成$ g compose f: F->H $もまたgraph mapとなる。
  + graph map$f:F->G,g:G->H,h:H->L$に対して、結合律$ (h compose g) compose f = h compose (g compose f) $が成り立つ。
  + 各graph$G$に対して、$id_G : G -> G$があって、任意のgraph map$f:G->H$に対して、$ id_H compose f = f = f compose id_G $が成り立つ。
])

#proof[
  (ii)と(iii)は$Set$における合成の定義から直ちに従う。以下(i)を示す。

  $f$と$g$がgraph mapであることから、$e in E(F)$に対して、\
  #align(center)[
    $f(e) subset e'$となるような$e' in E(G)$と\
    $g(e') subset e''$となるような$e'' in E(H)$\
  ]
  がとれる。このとき、
  $
    (g compose f)(e) = g(f(e)) subset g(e') subset e''
  $
  となる。$e in E(F)$は任意であるから、$g compose f$はgraph mapである。
]

ここまで敢えて圏論の用語を避けてきたが、圏の定義を知っている人には次のように述べた方が簡潔だろう。(知らない人は無視してもらって構わない。)

#theorem(kind: "命題",[
  graphを対象、graph mapを射とする圏$Grph$を定義できる。
])

以下、$G in Grph$は$G$がgraphであるという意味で用いる。

== 完全graph

#i さて、対応$V: Grph -> Set$(実は関手になっている)はgraphをその頂点集合に写すのであった。では、逆に頂点集合$V in Set$が与えられたとき自然な方法でgraphを定めることはできるのであろうか？その答えの一つが次の完全graphである。

#theorem(title: "完全graph", kind: "定義",[
  $V in Set$に対して、$K(V) = (V,power(V)) in Grph$を$V$を頂点とする*完全graph*という。
])





#pagebreak()

#bibliography("hypergraph.bib", title: "参考文献")