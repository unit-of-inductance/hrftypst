#import "@preview/t4t:0.3.2": def
#import "@preview/ctheorems:1.1.3": *
// #import "@preview/physica:0.8.0": *
// #import "@preview/physica:0.8.0": *
#import "@preview/equate:0.2.1": equate
#show: thmrules.with(qed-symbol: $square$)
              



// logic and set theory stuff
#let containing = sym.in.rev
#let maps = [#h(0%):]
#let logicspace = h(0.5em)
#let holds = [#h(0%):]
#let suchThat = holds
#let inverse(body) = [$#body^(-1)$]
#let impliedBy = sym.arrow.l.double.long
#let implies = sym.arrow.r.double.long
#let iff = sym.arrow.l.r.double.long
#let given = math.class("relation", sym.bar.v)

#let setminus = $without$ // use without instead
#let sim = $tilde.op$
#let mapsTo = sym.arrow.r.bar
#let to = sym.arrow.r

#let blank = sym.dash

#let definedAs = sym.colon.eq
#let defines = sym.eq.colon
#let isomorphic = sym.tilde.equiv

// braket stuff
#let braket(bra, ket, apply: false, size: auto) = (
  $lr(angle.l bra mid(bar.v) #if (apply!=false) [$apply mid(bar.v)$] else [] ket angle.r,size:size)$
)
#let ket(content, size: auto) = $lr(bar.v content angle.r,size:size)$
#let bra(content, size: auto) = $lr(angle.l content bar.v,size:size)$

#let expectedvalue(content, size: auto) = $lr(angle.l content angle.r,size:size)$

// explanations
#let underarrow(toBeExplained, explanation, width: 1000pt) = (
  $limits(toBeExplained)_(limits(#box(box(explanation,width:width),width:0pt))^(arrow.t))$
)

// pairings
#let poissonBracket(arg1, arg2, size: auto) = $lr({arg1,arg2},size:size)$
#let scalarproduct(arg1, arg2, size: auto) = $lr(angle.l arg1, arg2 angle.r,size:size)$

// intervals, open can be one of "left", "right", "both", "none"
#let interval(
  a,
  b,
  open: "none",
  leftOpenFence: "(",
  rightOpenFence: ")",
  leftClosedFence: "[",
  rightClosedFence: "]",
) = [
  #if (open == "none") [
    $leftClosedFence a,b rightClosedFence$
  ] else if (open == "left") [
    $leftOpenFence a,b rightClosedFence$
  ] else if (open == "right") [
    $leftClosedFence a,b rightOpenFence$
  ] else if (open == "both") [
    $leftOpenFence a,b rightOpenFence$
  ]
]

#let lInterval(a, b) = interval(a, b, open: "left")
#let rInterval(a, b) = interval(a, b, open: "right")
#let oInterval(a, b) = interval(a, b, open: "both")


#let mod(a, b) = calc.rem(calc.rem(a, b) + b, b)
#let quotient(Group, subGroup) = $Group\/subGroup$

#let reals = $bb(R)$
#let complexes = $bb(C)$
#let quaternions = $bb(H)$
#let rationals = $bb(Q)$
#let integers = $bb(Z)$
#let naturals = $bb(N)$

#let hbar = (sym.wj, move(dy: -0.08em, strike(offset: -0.55em, extent: -0.05em, sym.planck)), sym.wj).join()

#let sphere = $bb(S)$
#let torus = $bb(T)$

#let symplecticGroup = $op("Sp")$
#let generalGroup = $op("GL")$
#let orthogonalGroup = $op("O")$
#let specialOrthogonalGroup = $op("SO")$
#let unitaryGroup = $op("U")$
#let specialUnitaryGroup = $op("SU")$
#let specialGroup = $op("SL")$

#let automorphisms = $op("Aut")$
#let homomorphisms = $op("Hom")$
#let bijections = $op("Bij")$


// differential geometry specific
#let bisections = $frak(B)$

// riemannian geometry specific
#let laplacian = $Delta$



#let to_be_shown(body) = (
  context thmbox(
    "to_be_shown",
    if (text.lang == "en") {
      "To be shown"
    } else {
      "Zu zeigen"
    },
  ).with(numbering: none)
)

#let proof_forward = strong(quote[$implies$])
#let proof_backward = strong(quote[$impliedBy$])


#let theorem = thmbox(
  "theorem", // identifier
  "Theorem", // head
  fill: rgb("#e8e8f8")
)
#let lemma = thmbox(
  "theorem", // identifier - same as that of theorem
  "Lemma", // head
  fill: rgb("#efe6ff")
)
#let corollary = thmbox(
  "theorem", // identifier - same as that of theorem
  "Corollary", // head
  fill: rgb("#f0e6ff")
)
#let proof = thmproof("proof", "Proof")

#let definition = thmbox("definition", "Definition")

#let hSmash(body, side: center) = math.display(
  box(
    width: 0pt,
    align(
      side.inv(),
      box(width: float.inf * 1pt, $ script(body) $),
    ),
  ),
)

#let vSmash(body, side: center) = math.display(
  box(
    height: 0pt,
    align(
      side.inv(),
      box(width: float.inf * 1pt, $ script(body) $),
    ),
  ),
)


#let proof = thmplain(
  "proof",
  "Proof",
  bodyfmt: body => [#body #h(1fr)
    #h(1fr)
    #sym.wj
    #sym.space.nobreak
    #$square$],
).with(numbering: none)

#let hrfAssignment(
  university: "Georg-August-Universität Göttingen",
  short_university: "Uni Göttingen",
  authors: "Henry Ruben Fischer",
  title: "",
  semester: "WiSe 23/24",
  date: none, // today if none, otherwise pass date object
  due_date: none, // if none, use next week_day
  due_weekday: 5, // friday by default
  due_hour: 18, // always used
  numbering_string: ("1.","a.","1."),
  teacher,
  lang: "en",
  course,
  short_course,
  group,
  sheet_number,
  body,
) = {


  // internationalization

  // U+2116 is the numero glyph №
  let exercise_sheet_term = context if (text.lang == "en") [Exercises: Sheet \u{2116}] else [Aufgabenblatt]
  let exercise_group_term = context if (text.lang == "en") [Exercise group] else [Übungsgruppe]


  let time_format = "[hour padding:zero repr:24]:[minute padding:zero]"
  let date = def.if-none(
    datetime.today(), 	// default
    date, 		          // passed-in argument
  )
  let due_date = def.if-none(
    date+duration(days:mod(due_weekday -date.weekday(),7)), 	// default
    due_date, 		      // passed-in argument
  )
  let due_time = datetime(
    hour: due_hour,
    minute: 0,
    second: 0,
  )

  let sheet = (
    name: title,
    show_name: (teacher != ""),
  )


  let title = [#exercise_sheet_term #sheet_number#if (title != "") [: #title] else []]

  set document(
    author: authors,
    title: short_course + " - " + exercise_sheet_term + " " + str(sheet_number) + " Solutions - " + authors,
  )
  set page(
    header: context {
      let date_format = if (text.lang == "en") {
        "[month repr:long] [day padding:none], [year]"
      } else {
        "[day].[month].[year]"
      }
      set text(weight: "bold")
      if (counter(page).get().first() == 1) [
        #course #h(1fr) #if (lang == "en") [Written on] else [Erstellt am] #date.display(date_format) \
        #exercise_group_term #group #h(1fr) #if (lang=="en") [Due on ] else [Abgabe bis ] #due_date.display(date_format), #due_time.display(time_format) #if (lang == "de") [Uhr] else []
      ] else [
        #course #h(1fr) #authors \
        #exercise_sheet_term(lang: lang) #sheet_number #h(1fr) #date.display(date_format)
      ]
    },
    numbering: "1/1",
  )
  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #authors
  ]


  let exercise_numbering(..numbers) = (
    context {
      let problem_term = if (text.lang == "en") {
        ("Problem", "Part", "", "")
      } else {
        ("Aufgabe", "Teilaufgabe", "", "")
      }
      let values = numbers.pos()
      let n = values.len()
      [#problem_term.at(n - 1) #numbering(numbering_string.slice(0, n).join(), ..values) #h(0.5em)]
    }
  )
  set heading(numbering: exercise_numbering)


  // equation stuff
  show: equate.with(breakable: true, sub-numbering: true, number-mode: "label")
  set math.equation(numbering: "(1.1)", supplement: none) // default numbering

  show ref: it => {
    // provide custom reference for equations
    if it.element != none and it.element.func() == math.equation {
      // optional: wrap inside link, so whole label is linked
      [(#it)]
    } else {
      it
    }
  }
  body
}

#let hrfPresentation(
  university: "Georg-August-Universität Göttingen",
  short_university: "Uni Göttingen",
  authors: "Henry Ruben Fischer",
  semester: "WiSe 23/24",
  lang: "en",
  title,
  talkNumber,
  date,
  course,
  // teacher,
  // short_course,
  body,
) = {
  import "@preview/polylux:0.3.1": *
  import themes.metropolis: *
  show: metropolis-theme
  set text(lang: lang, size: 20pt)
  // set text(font: "Fira Sans", weight: "light", size: 20pt)
  // show math.equation: set text(font: "Fira Math")
  let subtitle = "Seminar - " + course + " - Talk " + str(talkNumber)
  title-slide(
    title: title,
    subtitle: subtitle,
    author: authors,
    date: date,
    extra: image("Uni Goettingen - Logo 4c RGB - 600dpi.png", width: 50%),
  )
  slide(title: "Outline")[
    #metropolis-outline
  ]
  body
}

#let hrfHandout(
  university: "Georg-August-Universität Göttingen",
  short_university: "Uni Göttingen",
  authors: "Henry Ruben Fischer",
  semester: "WiSe 23/24",
  lang: "en",
  title,
  talkNumber,
  date,
  course,
  // teacher,
  // short_course,
  body,
) = {
  let subtitle = "Seminar - " + course + " - Talk " + str(talkNumber)
}