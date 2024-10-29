#import "@preview/t4t:0.3.2": def
#import "@preview/ctheorems:1.0.0": *
// #import "@preview/physica:0.8.0": *
#show: thmrules

#let hbar = (sym.wj, move(dy: -0.08em, strike(offset: -0.55em, extent: -0.05em, sym.planck)), sym.wj).join()
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
#let setminus = $backslash$
#let sim = $tilde.op$
#let mapsTo = sym.arrow.r.bar
#let to = sym.arrow.r

#let blank = sym.dash

#let definedAs = sym.colon.eq
#let defines = sym.eq.colon

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


#let mod(a, b) = calc.rem(calc.rem(a, b) + b, b)
#let quotient(Group, subGroup) = $Group\/subGroup$

#let reals = $bb(R)$
#let complexes = $bb(C)$
#let quaternions = $bb(H)$
#let rationals = $bb(Q)$
#let integers = $bb(Z)$

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

#let laplacian = $Delta$



#let to_be_shown(lang: "en", body) = {
  box(inset: 5pt, baseline: 5pt, stroke: (dash: "solid", paint: black))[#if (
      lang == "en"
    ) [To be shown: ] else [Zu zeigen: ]#body]
}

#let proof_forward = #strong(quote[$implies$])
#let proof_backward = #strong(quote[$impliedBy$])


// #let theorem = thmbox("theorem", "Theorem")
// #let claim = thmbox("claim", "Claim")
// #let proof = thmplain(
//   "proof",
//   "Proof",
//   bodyfmt: body => [#body #h(1fr) $square$]
// ).with(numbering: none)
// #let definition = thmbox("definition", "Definition")

#let hrfassignment(
  university: "Georg-August-Universität Göttingen",
  short_university: "Uni Göttingen",
  authors: "Henry Ruben Fischer",
  title: "",
  semester: "WiSe 23/24",
  date: none, // today if none, otherwise pass date object
  due_date: none, // if none, use next week_day
  due_weekday: 5, // friday by default
  due_hour: 18, // always used
  lang: "en",
  numbering_string: ("1.","a.","1."),
  teacher,
  course,
  short_course,
  group,
  sheet_number,
  body,
) = {


  // internationalization
  let problem_term(lang: "en") = if (lang == "en") {
    ("Problem", "Part", "", "")
  } else {
    ("Aufgabe", "Teilaufgabe", "", "")
  }

  // U+2116 is the numero glyph №
  let exercise_sheet_term(lang: "en") = if (lang == "en") [Exercises: Sheet \u{2116}] else [Aufgabenblatt]
  let exercise_group_term(lang: "en") = if (lang == "en") [Exercise group] else [Übungsgruppe]

  let date_format = "[month repr:long] [day padding:none], [year]"
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

  set text(lang: lang)
  // set to_be_shown(lang: lang)

  let title = [#exercise_sheet_term(lang: lang) #sheet_number#if (title != "") [: #title] else []]

  set document(
    author: authors,
    title: short_course + " - Exercise Sheet " + str(sheet_number) + " Solutions - " + authors,
  )
  set page(
    header: locate(loc => {
      set text(weight: "bold")
      if (loc.page() == 1) [
        #course #h(1fr) Written on #date.display(date_format) \
        #exercise_group_term(lang:lang) #group #h(1fr) #if(lang=="en") [Due on ] else [Abgabe bis ] #due_date.display(date_format), #due_time.display(time_format)
      ] else [
        #course #h(1fr) #authors \
        #exercise_sheet_term(lang: lang) #sheet_number #h(1fr) #date.display(date_format)
      ]
    }),
    numbering: "1/1",
  )
  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #authors
  ]


  let exercise_numbering(..numbers) = {
    let values = numbers.pos()
    let n = values.len()
    [#problem_term(lang: lang).at(n - 1) #numbering(numbering_string.slice(0, n).join(), ..values) #h(0.5em)]
  }
  set heading(numbering: exercise_numbering)

  body
}

#let hrfpresentation(
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

#let hrfhandout(
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