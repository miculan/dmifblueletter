%% This is file `dmifblueletter.cls'
%%
%% Version 2.0 (2026/11/20)
%%
%% Derived from `dmifletter.cls' v1.1 (February 2, 2016), which is in turn
%% derived from Simone Martini & TeX Guru's "dimiletter.cls".
%%
%% This copy has been RENAMED (dmifblueletter) as required by the licence
%% notice of the original file, which is reproduced below.  Changes with
%% respect to dmifletter.cls v1.1:
%%   - the old header image (dmifhead.pdf), the small logo of the following
%%     pages and the C.F./P.I. footer are replaced by the new DMIF blue
%%     letterhead (background image dmif-sfondo.png + header/footer texts),
%%     drawn on every page;
%%   - page geometry follows the letterhead (A4, text starts at 113.4bp from
%%     the top, 113.4bp bottom margin);
%%   - new commands \responsabile, \compilatore, \dipartimento, \indirizzo,
%%     \sitoweb; \email and \telephone now feed the footer;
%%   - new options `nosfondo' (no letterhead, for pre-printed paper) and
%%     `englishhead' (letterhead in English);
%%   - \opening now ends with \startbreaks: in v1.1 the \stopbreaks at its
%%     beginning stayed active for the whole body, so paragraphs could never
%%     be split across pages (removing that line restores the old behaviour).
%%
%% ---- Original licence notice ----------------------------------------------
%% Permission is granted to copy this file to another file with a
%% clearly different name and to customize the declarations in that
%% copy to serve the needs of your installation, provided that you
%% comply with the conditions in the file legal.txt.
%%
%% However, NO PERMISSION is granted to generate or to distribute a
%% modified version of this file under its original name.
%%
%% You are NOT ALLOWED to change this file.
%%
%% MODIFICATION ADVICE:
%%
%% If you want to customize this file, it is best to make a copy of
%% the source file(s) from which it was produced. Use a different
%% name for your copy(ies) and modify the copy(ies); this will ensure
%% that your modifications do not get overwritten when you install a
%% new release of the standard system. You should also ensure that
%% your modified source file does not generate any modified file with
%% the same name as a standard file.
%%
%% You can then easily distribute your modifications by distributing
%% the modified and renamed copy of the source file, taking care to
%% observe the conditions in legal.txt; this will ensure that other
%% users can safely use your modifications.
%% ---------------------------------------------------------------------------
%%
%% Commands provided by this class (in addition to the standard ones
%% provided by letter.cls):
%%
%% \email{addr}    complete email address of the sender (shown in the footer)
%% \subject{text}  subject of the letter
%%
%% Optional footer lines of the letterhead (all optional):
%% \responsabile{name}{email}   "Responsabile del procedimento: ..."
%% \compilatore{name}{email}    "Compilatore del procedimento: ..."
%% \dipartimento{text}  \indirizzo{text}  \sitoweb{www....}
%% \telephone{number}           (standard letter command) full phone number
%%
%% Options: english (default) | italian | englishhead | nosfondo | 10pt, 11pt, ...
%%   englishhead   letterhead in English (department name, "Italy", footer labels);
%%                 the default letterhead is in Italian, whatever the letter language
%%
\NeedsTeXFormat{LaTeX2e}[1994/12/01]
\ProvidesClass{dmifblueletter}
          [2026/11/20 v2.0 DMIF letter with blue letterhead]
\message{DMIF blue LetterHead, 2026/11/20 v2.0}

\RequirePackage{ifthen}
\RequirePackage{epsfig}      % kept for compatibility (also loads graphicx)
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{eso-pic}
\RequirePackage{url}

\newboolean{@@italiano}
\setboolean{@@italiano}{false}
\DeclareOption{italian}{\setboolean{@@italiano}{true}}

\newif\ifdmif@sfondo \dmif@sfondotrue
\DeclareOption{nosfondo}{\dmif@sfondofalse}
\newif\ifdmif@enghead \dmif@engheadfalse
\DeclareOption{englishhead}{\dmif@engheadtrue}

\definecolor{dmifblue}{HTML}{0000FF}   % blue of the letterhead texts
\definecolor{dmifweb}{HTML}{467886}    % colour of the web address

%% Pass all the standard letter options; then go with a4 paper

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[a4paper]{letter}

%% Set up things for Italian names

\newcommand{\englishnames}{%
  \newcommand{\subjectstring}{Subject}
  \newcommand{\telstring}{+39 0432\ifx\telephonenum\@empty 55 8400
                                      \else\telephonenum\fi}
  \newcommand{\faxstring}{+39 043255 8499}
  \newcommand{\citystring}{I-33100 Udine, Italy}
  \date{Udine, \today}
}

\newcommand{\italiannames}{%
  \newcommand{\subjectstring}{Oggetto}
  \newcommand{\telstring}{0432\ifx\telephonenum\@empty 55 8400
                                      \else\telephonenum\fi}
  \newcommand{\faxstring}{043255 8499}
  \newcommand{\citystring}{33100 Udine}
  \date{Udine, l\`\i\ \today}
}

\ifthenelse{\boolean{@@italiano}}
  {\usepackage[italian]{babel}\italiannames}{\englishnames}

\newcommand{\@subject}{}
\def\@email{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{{\sc \subjectstring}: #1}}
\newcommand{\email}[1]{\def\@email{#1}}

%% ------------------------------------------------------------ page geometry
%% A4. The text area starts 113.4bp from the top and ends 113.4bp from the
%% bottom, i.e. below the letterhead and above its footer.  (bp = PostScript
%% points, as in the Word template.)  Width and side margins are those of the
%% original dmifletter class (160mm, left margin 1in).

\setlength{\textwidth}{160mm}
\setlength{\oddsidemargin}{0in}
\setlength{\evensidemargin}{0in}
\setlength{\headheight}{12pt}
\setlength{\headsep}{14pt}
\setlength{\topmargin}{\dimexpr 113.4bp-1in-\headheight-\headsep\relax}
\setlength{\textheight}{\dimexpr\paperheight-226.8bp\relax}

%% ---------------------------------------------------------- letterhead data
\def\dmif@respnome{}
\def\dmif@respmail{}
\def\dmif@compnome{}
\def\dmif@compmail{}
\def\dmif@web{www.dmif.uniud.it}
\ifdmif@enghead   % ---- intestazione in inglese (opzione englishhead)
  \def\dmif@dipartimento{Department of Mathematics, Computer Science and Physics}
  \def\dmif@indirizzo{via delle Scienze 206, 33100 Udine (UD), Italy}
  \def\dmif@respstring{Person in charge of the procedure}
  \def\dmif@compstring{Prepared by}
  \newcommand{\dmif@headleft}{%
    Department of Mathematics, Computer Science and Physics}
  \newcommand{\dmif@headright}{%
    via delle Scienze 206\\ 33100 Udine, Italy \\ www.dimi.uniud.it}
\else             % ---- intestazione in italiano (predefinita)
  \def\dmif@dipartimento{Dipartimento di scienze Matematiche, Informatiche e Fisiche}
  \def\dmif@indirizzo{via delle Scienze 206, 33100 Udine (UD), Italia}
  \def\dmif@respstring{Responsabile del procedimento}
  \def\dmif@compstring{Compilatore del procedimento}
  \newcommand{\dmif@headleft}{%
    Dipartimento di scienze Matematiche, Informatiche e Fisiche}
  \newcommand{\dmif@headright}{%
    via delle Scienze 206\\ 33100 Udine, Italia \\ www.dmif.uniud.it}
\fi

\newcommand{\dipartimento}[1]{\def\dmif@dipartimento{#1}}
\newcommand{\responsabile}[2]{\def\dmif@respnome{#1}\def\dmif@respmail{#2}}
\newcommand{\compilatore}[2]{\def\dmif@compnome{#1}\def\dmif@compmail{#2}}
\newcommand{\indirizzo}[1]{\def\dmif@indirizzo{#1}}
\newcommand{\sitoweb}[1]{\def\dmif@web{#1}}

%% Telephone number of the footer: general number unless \telephone is used.
\newcommand{\dmif@tel}{\ifx\telephonenum\@empty +39 0432 558400\else\telephonenum\fi}

%% Addresses are links only if the user loads hyperref.  The argument is
%% expanded first, because url does not expand macros.
\DeclareUrlCommand\dmif@url{\urlstyle{same}}
\newcommand{\dmif@urlx}[1]{\begingroup\edef\dmif@tmp{#1}%
  \expandafter\dmif@url\expandafter{\dmif@tmp}\endgroup}
\AtBeginDocument{%
  \@ifpackageloaded{hyperref}%
    {\newcommand{\dmif@mail}[1]{\begingroup\edef\dmif@tmp{#1}%
        \href{mailto:\dmif@tmp}{\dmif@urlx{\dmif@tmp}}\endgroup}%
     \newcommand{\dmif@weblink}[1]{\begingroup\edef\dmif@tmp{#1}%
        \href{http://\dmif@tmp}{\color{dmifweb}\underline{\dmif@urlx{\dmif@tmp}}}\endgroup}}%
    {\newcommand{\dmif@mail}[1]{\dmif@urlx{#1}}%
     \newcommand{\dmif@weblink}[1]{\color{dmifweb}\underline{\dmif@urlx{#1}}}}}

%% Text of the footer; the optional lines appear only when their data are set.
\newcommand{\dmif@foottext}{%
  \dmif@dipartimento
  \ifx\dmif@respnome\@empty\else
    \\ \dmif@respstring: \dmif@respnome\ - \dmif@mail{\dmif@respmail}\fi
  \ifx\dmif@compnome\@empty\else
    \\ \dmif@compstring: \dmif@compnome\ - \dmif@mail{\dmif@compmail}\fi
  \ifx\@email\@empty\else
    \\ \ifx\fromname\@empty\else\fromname\ - \fi\dmif@mail{\@email}\fi
  \\ \dmif@indirizzo\ - t \dmif@tel\ - \dmif@weblink{\dmif@web}}

%% ------------------------------------------------------------- letterhead
%% Background of every page: logo, rules and footer marks (PNG extracted from
%% the Word template) plus the three text boxes, set in Helvetica.
\newcommand{\dmif@sf}{\fontfamily{phv}\fontseries{m}\fontshape{n}\selectfont}
\newcommand{\dmif@put}[3]{\put(\LenToUnit{#1bp},-\LenToUnit{#2bp}){#3}}

\newcommand{\dmif@carta}{%
  \AtPageUpperLeft{%
    \dmif@put{-5.25}{841.3}{%
      \includegraphics[width=595.25bp,height=841.3bp]{dmif-sfondo.png}}%
    \dmif@put{344.2}{40.55}{\makebox(0,0)[tl]{%
      \parbox[t]{120.2bp}{\raggedright\color{dmifblue}\dmif@sf\bfseries
        \fontsize{8}{8.6}\selectfont\dmif@headleft}}}%
    \dmif@put{478.7}{40.8}{\makebox(0,0)[tl]{%
      \parbox[t]{88.1bp}{\raggedright\color{dmifblue}\dmif@sf
        \fontsize{8}{8.6}\selectfont\dmif@headright}}}%
    \dmif@put{146.25}{801.0}{\makebox(0,0)[bl]{%
      \parbox[b]{301.6bp}{\raggedright\dmif@sf\fontsize{6}{7.6}\selectfont
        \dmif@foottext}}}%
  }%
}

\ifdmif@sfondo
  \AddToShipoutPictureBG{\dmif@carta}%
\fi

%% ------------------------------------------------------------ page styles
%% First page: nothing besides the letterhead.
\renewcommand{\ps@firstpage}
   {\renewcommand{\@oddhead}{}%
    \renewcommand{\@evenhead}{}%
    \renewcommand{\@oddfoot}{}%
    \renewcommand{\@evenfoot}{}}

%% Following pages: letterhead + page number, right aligned, above the text.
\renewcommand{\ps@headings}
   {\renewcommand{\@oddhead}
       {\hfill{\color{dmifblue}\dmif@sf\fontsize{8}{9}\selectfont
               \pagename{}\ \thepage}}%
    \renewcommand{\@oddfoot}{}%
    \renewcommand{\@evenhead}{\@oddhead}%
    \renewcommand{\@evenfoot}{\@oddfoot}%
   }

\providecommand{\@oddhead}{}\providecommand{\@evenhead}{}
\providecommand{\@oddfoot}{}\providecommand{\@evenfoot}{}

\pagestyle{headings}

\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
  \stopbreaks
  \begin{flushright}
  \parbox[t]{\indentedwidth}{\raggedright
       \ \\[6mm]
       \@date  \\[9mm]
       \toname \\ \toaddress
  }  \vspace{2\parskip}
  \end{flushright}
  \ifthenelse{\equal{\@subject}{}}
             {}{\@subject\par}
  \vspace{2\parskip} #1 \par\nobreak
  \startbreaks}   % v2.0: re-enable page breaks inside the letter body

\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
  \stopbreaks
  \noindent
  {\raggedleft
  \ifx\@empty\fromaddress\else
    \hspace*{\longindentation}\fi
  \parbox{\indentedwidth}{%\raggedright
       \ignorespaces #1\\[6\medskipamount]%
       \ifx\@empty\fromsig
           \fromname
       \else \fromsig \fi\strut}%
   \par\nobreak\vspace{\parskip}}}

\raggedbottom
\indentedwidth=.5\textwidth

%% End of file `dmifblueletter.cls'.
