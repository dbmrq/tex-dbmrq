\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dbmrq}

% Options >>>1

\RequirePackage{etoolbox}

% paper >>>2
\providebool{paper}
\DeclareOption{paper}{\booltrue{paper}}
% <<<2

% thesis >>>2

\providebool{thesis}
\DeclareOption{thesis}{\booltrue{\thesis}}

% phd >>>3
\DeclareOption{phd}{\booltrue{thesis}}
\DeclareOption{phdthesis}{\booltrue{thesis}}
\DeclareOption{doctors}{\booltrue{thesis}}
% <<<3

% masters >>>3
\providebool{masters}
\DeclareOption{masters}{
  \booltrue{masters}
  \booltrue{thesis}
}
\DeclareOption{mathesis}{
  \booltrue{masters}
  \booltrue{thesis}
}
% <<<3

% <<<2

% strict >>>2
\providebool{strict}
\DeclareOption{strict}{\booltrue{strict}}
\DeclareOption{abnt}{\booltrue{strict}}
% <<<2

% parskip >>>2
\DeclareOption{useparskip}{\abnormalparskip{0.3\baselineskip}}
\DeclareOption{parskip}{\abnormalparskip{0.3\baselineskip}}
% <<<2

% stretch >>>2
\DeclareOption{usestretch}{\setlength{\emergencystretch}{1em}}
\DeclareOption{stretch}{\setlength{\emergencystretch}{1em}}
% <<<2

% nobib >>>2
\providebool{nobib}
\DeclareOption{nobib}{\booltrue{nobib}}
% <<<2

% nofonts >>>2
\providebool{nofonts}
\DeclareOption{nofonts}{\booltrue{nofonts}}
% <<<2

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ProcessOptions\relax

\LoadClass[12pt, oneside, openany, a4paper, article]{memoir}

% Fix http://tex.stackexchange.com/q/323924/102699
\newcommand\chapterblock{\vskip0pt}

% <<<1

% Packages >>>1

\RequirePackage{indentfirst}
\RequirePackage{sensible}
\RequirePackage{lipsum}
\RequirePackage{xstring}
\RequirePackage{mfirstuc}
\RequirePackage{lastpage}
\RequirePackage{lettrine}

\RequirePackage{mdframed}
\mdfsetup{%
  innertopmargin=1em,
  innerbottommargin=3em,
  innerleftmargin=2em,
  innerrightmargin=3em,
  font=\ttfamily\small%
}

\RequirePackage[xlatin]{foreign}
\renewcommand\foreignabbrfont{}
\let\cf\@undefined

% ou hang em vez de marginal, pra não ficar voando
\RequirePackage[bottom, marginal, perpage]{footmisc}

\AtEndPreamble{\RequirePackage{hyperref}}

% <<<1

% Margins >>>1

\notbool{strict}{
  \settypeblocksize{210mm}{148mm}{*}
  %\setbinding{1cm}
  \setulmargins{*}{*}{1.618}
  \setlrmargins{*}{*}{0.618}
  \setheadfoot{\onelineskip}{2\onelineskip}
  \setheaderspaces{*}{\onelineskip}{*}
  \setlength{\topskip}{1.6\topskip}
  \checkandfixthelayout
  \sloppybottom
}{
	\setulmarginsandblock{3cm}{2cm}{*}
	\setlrmarginsandblock{3cm}{2cm}{*}
	\setheadfoot{\onelineskip}{2\onelineskip}
	\setheaderspaces{*}{2\onelineskip}{*}
  \setlength{\topskip}{1.6\topskip}
  \checkandfixthelayout
  \sloppybottom
}

% <<<1

% Fonts >>>1

\notbool{nofonts}{% >>>2

  \RequirePackage{iftex}

  \ifPDFTeX% >>>3
  % <<<3

  \else% >>>3

    \ifXeTeX%% XeTeX >>>4
      \usepackage{fontspec}
      \setmainfont
          [Numbers={OldStyle,Proportional},
          Ligatures=TeX,
          ItalicFont={* Italic},
          BoldFont={* Medium},
          BoldItalicFont={* Medium Italic}]
          {Minion Pro}
      \newfontfamily{\SemiBold}{Minion Pro Semibold}
      \newfontfamily{\FullBold}{Minion Pro Bold}
      \newfontface\Swash{MinionPro-ItDisp}[Contextuals=Swash]
      \newfontface\Disp{MinionPro-Disp}[Contextuals=Swash]
      \setmonofont{Inconsolata}% <<<4

    \else%% LuaTeX >>>4
      \usepackage{fontspec}
      \setmainfont
          [Numbers={OldStyle,Proportional},
          Ligatures=TeX,
          ItalicFont={MinionPro-It},
          BoldFont={MinionPro-Medium},
          BoldItalicFont={MinionPro-MediumIt}]
          {MinionPro-Regular}
      \newfontfamily{\SemiBold}{MinionPro-Semibold}
      \newfontfamily{\FullBold}{MinionPro-Bold}
      \newfontface\Swash{MinionPro-ItDisp}[Contextuals=Swash]
      \newfontface\Disp{MinionPro-Disp}[Contextuals=Swash]
      \setmonofont{Inconsolata}
      \usepackage{unicode-math}
      \setmathfont{MinionMath-Regular}
    \fi% <<<4

    \defaultfontfeatures{Ligatures=TeX}

    \thickmuskip=5mu plus 3mu minus 1mu

    \newcommand\lf{\addfontfeature{Numbers=Lining}}

  \fi% <<<3

}% <<<2

% <<<1

% Headers and footers >>>1

\makepagestyle{simpleheader}
\makeevenhead{simpleheader}{\thepage}{}{}
\makeoddhead{simpleheader}{}{}{\thepage}
\makeevenfoot{simpleheader}{}{}{}
\makeoddfoot{simpleheader}{}{}{}

\makepagestyle{dbmheader}
\makeevenhead{dbmheader}{%
  \thepage \quad \MakeLowercase{\scshape \leftmark}%
}{}{}
\makeoddhead{dbmheader}{}{}{%
  \MakeLowercase{\scshape \rightmark} \quad \thepage%
}

\renewcommand*{\footnotelayout}{\footnotesize}

% <<<1

% Sections, chapters and parts >>>1

% Section, subsection and subsubsection >>>2

\setsecheadstyle{\normalfont\scshape\large\MakeLowercase}

\ifbool{paper}{%
  \setsubsecheadstyle{\normalfont\scshape\MakeLowercase}%
}{%
  \setsubsecheadstyle{\normalfont\bfseries}%
  % \setsubsecheadstyle{\sethangfrom{#1}\normalfont\small}
  \setsecnumdepth{subsection}

  \setsubsubsecheadstyle{\Swash}
  % \setsubsubsecindent{\parindent}
  \setbeforesubsubsecskip{1.6\baselineskip}
  \setaftersubsubsecskip{.6\baselineskip}
}

\hangsecnum

% <<<2

% Chapter >>>2

\aliaspagestyle{chapter}{simpleheader}

\makechapterstyle{dbmhangnum}{% >>>3
  \chapterstyle{default}
  \setlength{\beforechapskip}{40pt}
  \setlength{\afterchapskip}{20pt}
  \renewcommand*{\chapterheadstart}{\vspace{\beforechapskip}}
  \settowidth{\chapindent}{%
    \normalfont\scshape\HUGE \thechapter \normalfont\normalsize\quad%
  }
  \renewcommand*{\printchaptername}{}
  \renewcommand*{\chapternamenum}{}
  \renewcommand*{\printchapternum}{%
    \noindent\llap{\makebox[\chapindent][l]{\chapnumfont \thechapter}}}
  \renewcommand*{\afterchapternum}{}%
    \renewcommand*{\printchaptertitle}[1]{\MakeLowercase{\chaptitlefont ##1}}
    \renewcommand*{\chapnamefont}{\normalfont\Large\scshape}
   \renewcommand*{\chaptitlefont}{\normalfont\Large\scshape}
    \renewcommand*{\chapnumfont}{\normalfont\Large\scshape}
}% <<<3

% TODO: Usar Large quando o capítulo começa na mesma
% página e HUGE quando começa sempre numa página nova.
\chapterstyle{dbmhangnum}

% <<<2

% Part >>>2

\aliaspagestyle{part}{empty}

\ifbool{paper}{%
  \renewcommand*{\parttitlefont}{\normalfont\Large\Swash}
  \renewcommand*{\partnamefont}{\normalfont\Capt\scshape\Large\MakeLowercase}
  \renewcommand*{\partnumfont}{\normalfont\Capt\scshape\Large\MakeLowercase}
}{
  \renewcommand*{\parttitlefont}{\normalfont\Large\Swash}
  \renewcommand*{\partnamefont}{\normalfont\scshape\Large\MakeLowercase}
  \renewcommand*{\partnumfont}{\normalfont\scshape\Large\MakeLowercase}
}

\renewcommand*{\afterpartskip}{%
  \par%
  \vskip 30pt%
  \begin{center}{\par\hspace{-3pt}\HUGE\symbol{57537}}\end{center}%
  \vfil\newpage%
}%
\renewcommand*{\midpartskip}{\par\vskip 10pt}%

% <<<2

% <<<1

% Cover and title page >>>1

% User variables >>>2

\newcommand*{\cuttercode}[1]{\gdef\@cuttercode{#1}}
\newcommand*{\@cuttercode}{\textbackslash cuttercode}

\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\@university}{Universidade de São Paulo}

\newcommand*{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand*{\@faculty}{Faculdade de Filosofia, Letras e Ciências Humanas}

\newcommand*{\department}[1]{\gdef\@department{#1}}
\newcommand*{\@department}{\textbackslash department}

\newcommand*{\field}[1]{\gdef\@field{#1}}
\newcommand*{\@field}{\textbackslash field}

\newcommand*{\committee}[1]{\gdef\@committee{#1}}
\newcommand*{\@committee}{\textbackslash committee}

\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\@supervisor}{\textbackslash supervisor}

\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand*{\@keywords}{\textbackslash keywords}

\newcommand*{\organization}[1]{\gdef\@organization{#1}}
\newcommand*{\@organization}{%
  \@university \protect\\
  \@faculty
}

\renewcommand{\epigraph}[1]{\gdef\@epigraph{#1}}
\newcommand{\@epigraph}{\lipsum[1]}

\newcommand*{\location}[1]{\gdef\@location{#1}}
\newcommand*{\@location}{São Paulo}

\ifbool{masters}{%
  \newcommand*{\goal}[1]{\gdef\@goal{#1}}
  \newcommand*{\@goal}{Mestre em \@field}
  \newcommand*{\program}[1]{\gdef\@program{#1}}
  \newcommand*{\@program}{Mestrado}
  \newcommand*{\thesistype}[1]{\gdef\@thesistype{#1}}
  \newcommand*{\@thesistype}{Dissertação}
}{%
  \ifbool{thesis}{%
    \newcommand*{\goal}[1]{\gdef\@goal{#1}}
    \newcommand*{\@goal}{Doutor em \@field}
    \newcommand*{\program}[1]{\gdef\@program{#1}}
    \newcommand*{\@program}{Doutorado}
    \newcommand*{\thesistype}[1]{\gdef\@thesistype{#1}}
    \newcommand*{\@thesistype}{Tese}
  }
}

\renewcommand*{\@date}{\the\year}

% <<<2

% Author name commands >>>2

\newcommand*\LastName[1]{\expandafter\lastname\expandafter{\expandafter}#1 \relax}
\def\lastname#1#2 #3{%
  \ifx\relax#3%
  #2%
  \expandafter\xthree%
  \fi%
  \lastname{#1 #2}#3%
}
\def\xthree#1#2#3{}

\newcommand*\FirstName[1]{\expandafter\firstname\expandafter{\expandafter}#1 \relax}
\def\firstname#1#2 #3{%
  \ifx\relax#3%
  #1%
  \expandafter\xthree%
  \fi%
  \firstname{#1 #2}#3%
}
\def\xthree#1#2#3{}

\newcommand{\LASTFirst}[1]{%
  \MakeUppercase{\LastName{#1}},\FirstName{#1}%
}

\newcommand{\LastFirst}[1]{%
  \LastName{#1},\FirstName{#1}%
}

% <<<2

\renewcommand{\maketitle}{% >>>2

  \begin{center}%
    {\Large \@title \par}%
    \vskip 2em%
    {\large
     \lineskip .75em%
      \begin{tabular}[t]{c}%
        \@author
      \end{tabular}\par}%
      \vskip 1em%
    {\large \@date \par}%
  \end{center}\par
}% <<<2

\newcommand{\makecover}{% >>>2
  \begin{titlingpage}%
    \calccentering{\unitlength}
    \begin{adjustwidth*}{\unitlength}{-\unitlength}
      \center
      {\large \textsc{\MakeLowercase{\@organization}}}
      \vfill
      {\large \@author}
      \vfill
      {\Large \textbf{\@title}}
      \vfill
      {\large \@location \\ \@date}
    \end{adjustwidth*}
  \end{titlingpage}
}% <<<2

\newcommand{\maketitlepage}{% >>>2
  \begin{titlingpage}%
    \center
    {\large \@author}
    \vfill
    {\Large \@title}
    \vfill
      \hspace{.5\textwidth}
      \begin{minipage}{.49\textwidth}
      	\SingleSpacing
        \@thesistype\ apresentada à \@faculty\ da \@university\ para obtenção
        do título de \@goal\ sob oriação do Prof.  Dr. \@supervisor.
       \end{minipage}%
    \vfill
    {\large \@location \\ \@date}
  \end{titlingpage}
}% <<<2

\newcommand{\makecolophon}{% >>>2
  \begin{titlingpage}%
    \noindent  Autorizo a reprodução e divulgação total ou parcial deste
    trabalho, por qualquer meio, convencional ou eletrônico, para fins de
    estudo e pesquisa, desde que citada a fonte.
    \vfill
    \begin{center}
    Catalogação na Publicação

    Serviço de Biblioteca e Documentação

    \@faculty da \@university
    \end{center}
    \vspace{-0.75\baselineskip}

    \begin{mdframed}
    \begin{raggedright}

      % \small

      \vspace{2\baselineskip}
      \@cuttercode

      \hspace*{0.15\textwidth}\begin{minipage}{0.85\textwidth}

      % \reversemarginpar
      % \marginnote{M357i}
      \begingroup
      \hyphenpenalty 10000
      \exhyphenpenalty 10000

      \vspace{-2\baselineskip}\vspace{-2\parskip}
      \LASTFirst{\@author}

      % \hspace{-5.5em} MM357i \hspace{3em}
      \hspace{2em} \@title\ / \@author; orientador \@supervisor\
      - \@location, \@date.

      \hspace{2em} \pageref{LastPage} p.

      \vspace{1em}

      \hspace{2em} \@thesistype\ (\@program) - \@faculty\ da \@university.
      \@department. Área de concentração: \@field.

      \vspace{1em}

      % \hspace{2em} 1. Filosofia. 2. Fenomenologia. 3. Lógica. 4. Idealidade.
      % 5. Husserl. I.  Ferraz, Marcus Sacrini Ayres, orient. II. Título.
      \hspace{2em}
      1. \StrBefore{\@keywords}{,}.
      2. \StrBetween[1,2]{\@keywords}{,}{,}.
      3. \StrBetween[2,3]{\@keywords}{,}{,}.
      4. \StrBetween[3,4]{\@keywords}{,}{,}.
      5. \StrBehind[4]{\@keywords}{,}.
      I. \LastFirst{\@supervisor}, orient. II. Título.

      \endgroup

    \end{minipage}

    \end{raggedright}
    \end{mdframed}

  \end{titlingpage}
}% <<<2

\newcommand{\makereference}{% >>>2
  \noindent \LASTFirst{\@author}. \emph{\@title}. \@date. \@thesistype\
  (\@program\ em \MakeLowercase{\@field}) -- \@faculty. \@department,
  \@university, \@location, \@date.
}% <<<2

\newcommand{\makeapproval}{% >>>2
    \begin{titlingpage}%
    \thispagestyle{empty}
    \makereference

    \vfil

    \noindent Aprovado em: \rule[-1pt]{8em}{0.4pt}

    \vfil\vfil\vfil

    \begin{center}

    \rule{\textwidth}{0.4pt}

    Prof. Dr. \@supervisor

    \vfil

    \rule{\textwidth}{0.4pt}

    Prof. \StrBefore{\@committee}{,}

    \vfil

    \rule{\textwidth}{0.4pt}

    Prof. \StrBehind{\@committee}{,}
    \end{center}
    \end{titlingpage}%
}% <<<2

\newcommand{\makethanks}{% >>>2
  \chapter{Agradecimentos}
  \lipsum[1-4]
}% <<<2

\newcommand{\makeepigraph}{% >>>2
  \thispagestyle{empty}
  \addcontentsline{toc}{chapter}{Epígrafe}
  \vspace*{\fill}
  \hfill
  \begin{minipage}{.85\textwidth}

  \abnormalparskip{0.7\baselineskip}%

  \@epigraph

  \end{minipage}
}% <<<2

\newcommand{\makeabstract}{% >>>2
  \chapter{Resumo}
  \makereference

  \hspace{\baselineskip}

  \lipsum[1-2]

  \hspace{\baselineskip}

  \noindent Palavras chave:

  \clearpage

  \chapter{Abstract}
  \makereference

  \hspace{\baselineskip}

  \lipsum[1-2]

  \hspace{\baselineskip}

  \noindent Keywords:
}% <<<2

% <<<1

% Quotes and enumerations >>>1

\setlist*[enumerate,1]{listparindent=\parindent, leftmargin=1.618\parindent}
\newlist{inline}{enumerate*}{1}
\setlist*[inline,1]{%
  label=(\arabic*)%
}
\newlist{inlinin}{enumerate*}{1}
\setlist*[inlinin,1]{%
  label=(\arabic*), itemjoin={{, }}, itemjoin*={{ e }}%
}
\newlist{inlinex}{enumerate*}{1}
\setlist*[inlinex,1]{%
  label=(\arabic*), itemjoin={{, }}, itemjoin*={{ ou }}%
}

\renewenvironment{quote}{%
  \small
  \begin{itemize}[leftmargin=3\parindent,
                  after=\vspace{0.3\baselineskip},
                  parsep=0.3\baselineskip]
    \begin{Spacing}{1}
      \item[]
}{%
    \end{Spacing}
  \end{itemize}
  \normalfont
}

% <<<1

% Sumário >>>1

% Sumário simples >>>2

% \renewcommand{\contentsname}{Sumário}
% \renewcommand{\cftchapterpresnum}{\lf}
% \renewcommand{\cftsectionpresnum}{\lf}
% \renewcommand{\cftpartpagefont}{\lf}
% \renewcommand{\cftchapterpagefont}{\lf}
% \renewcommand{\cftsectionpagefont}{\lf}
% \renewcommand{\aftertoctitle}{\thispagestyle{empty}\afterchaptertitle}
% \setlength{\cftparskip}{0.2\baselineskip}
% \renewcommand{\cftpartfont}{\normalfont\large}
% \renewcommand{\cftpartname}{Parte\space}

% <<<2

\renewcommand*{\contentsname}{Sumário}
\renewcommand*{\aftertoctitle}{\thispagestyle{empty}\afterchaptertitle}
\maxtocdepth{subsection}
\setlength{\cftparskip}{0.2\baselineskip}

\renewcommand{\cftpartfont}{\large}
\renewcommand{\cftpartleader}{}
\renewcommand{\cftpartafterpnum}{\cftparfillskip}
\cftsetindents{part}{1.5em}{0em}
\renewcommand{\partnumberline}[1]{}
\cftpagenumbersoff{part}

\setlength{\cftbeforechapterskip}{.5\baselineskip}
\renewcommand{\cftchapterfont}{\normalsize}
\renewcommand{\cftchapterpagefont}{\normalsize}
\renewcommand{\cftchapterpresnum}{\hspace*{-1.5em}}
\cftsetindents{chapter}{1.5em}{0em}
\renewcommand{\cftchapterleader}{}
\renewcommand{\cftchapterafterpnum}{\cftparfillskip}

\renewcommand{\cftsectionfont}{\small\bfseries}
\renewcommand{\cftsectionpagefont}{\small\bfseries}
\cftsetindents{section}{1.5em}{2.3em}
\renewcommand{\cftsectionleader}{}
\renewcommand{\cftsectionafterpnum}{\cftparfillskip}

\renewcommand{\cftsubsectionfont}{\small}
\renewcommand{\cftsubsectionpagefont}{\small}
\cftsetindents{subsection}{3.8em}{2em}
\renewcommand{\cftsubsectionleader}{}
\renewcommand{\cftsubsectionafterpnum}{\cftparfillskip}
% \setlength{\cftsubsectionnumwidth}{0}

% <<<1

% Misc >>>1

\setlength{\parindent}{2em}

\abnormalparskip{0.3\baselineskip}%

\raggedbottom

% <<<1

\AtBeginDocument{% >>>1

  % Começar a bibliografia numa página nova
  \ltx@ifpackageloaded{biblatex}{%
    \defbibheading{bibliography}[\bibname]{%
      \SingleSpace
      \def\clearpage{\newpage \write\m@ne{}\vbox{}\penalty -\@Mi}
      \chapter*{#1}
    }
    \renewcommand*{\bibnameunderscore}{%
      \rule[-1pt]{3em}{0.75pt}%
    }
    \bibhang 1em
  }{}

\frenchspacing

}% <<<1

\AfterEndPreamble{% >>>1

\ifbool{paper}{\makecover}

\ifbool{thesis}{% >>>2
  \SingleSpacing

  \pagestyle{simpleheader}
  % \pagestyle{dbmheader}

  \nouppercaseheads

  \frontmatter

  \makecover
  \clearpage
  \maketitlepage
  \clearpage
  \makecolophon
  \clearpage
  \makeapproval
  \clearpage
  \makethanks
  \clearpage
  \makeepigraph
  \clearpage
  \makeabstract
  \clearpage
  \tableofcontents*

  \mainmatter
}% <<<2

\ifbool{strict}{%
  \begin{Spacing}{1.4}
}{%
  \begin{Spacing}{1.5}
}

}% <<<1

\AtEndDocument {% >>>1

\end{Spacing}

\notbool{nobib}{%
  \ltx@ifpackageloaded{biblatex}{%
    % \clearpage
    \emergencystretch=1em
    \SingleSpacing
    \printbibliography
  }
}

}% <<<1
