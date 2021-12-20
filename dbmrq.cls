\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{dbmrq}

% Options >>>1

\RequirePackage{etoolbox}

% sfcover >>>2
\providebool{hardcover}
\DeclareOption{hardcover}{\booltrue{hardcover}}
% <<<2

% sfcover >>>2
\providebool{sfcover}
\DeclareOption{sfcover}{\booltrue{sfcover}}
% <<<2

% paper >>>2
\providebool{paper}
\DeclareOption{paper}{%
  \booltrue{paper}%
  \boolfalse{thesis}%
  \PassOptionsToClass{oneside}{memoir}
  \PassOptionsToClass{article}{memoir}
}
% <<<2

% section >>>2
\providebool{section}
\DeclareOption{section}{%
  \booltrue{section}%
}
% <<<2

% fapesp >>>2
\providebool{fapesp}
\DeclareOption{fapesp}{%
  \booltrue{fapesp}%
  \PassOptionsToClass{oneside}{memoir}
  \PassOptionsToClass{article}{memoir}
}
% <<<2

% project >>>2
\providebool{project}
\DeclareOption{project}{%
  \booltrue{project}%
  \PassOptionsToClass{oneside}{memoir}
  \PassOptionsToClass{article}{memoir}
}
% <<<2

% thesis >>>2

\providebool{thesis}
\DeclareOption{thesis}{\booltrue{\thesis}}
\DeclareOption{tese}{\booltrue{\thesis}}

% phd >>>3
\DeclareOption{phd}{\booltrue{thesis}}
\DeclareOption{phdthesis}{\booltrue{thesis}}
\DeclareOption{doctors}{\booltrue{thesis}}
\DeclareOption{doutorado}{\booltrue{thesis}}
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
\DeclareOption{mestrado}{
  \booltrue{masters}
  \booltrue{thesis}
}
% <<<3

% <<<2

% quali >>>2

\providebool{quali}
\DeclareOption{quali}{\booltrue{quali}}
\DeclareOption{qualification}{\booltrue{quali}}
\DeclareOption{qualificacao}{\booltrue{quali}}
\DeclareOption{qualificação}{\booltrue{quali}}

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

% Versão corrigida >>>2
\providebool{corrigida}
\DeclareOption{corrigida}{\booltrue{corrigida}}
% <<<2

% resetchapters >>>2
\providebool{resetchapters}
\DeclareOption{resetchapters}{\booltrue{resetchapters}}
% <<<2

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{memoir}}

\ProcessOptions\relax

\ifbool{quali}{%
  \LoadClass[12pt, a4paper]{memoir}
}{%
  \LoadClass[12pt, a4paper]{memoir}
}


% Fix http://tex.stackexchange.com/q/323924/102699
\newcommand\chapterblock{\vskip0pt}

% <<<1

% Packages >>>1

\RequirePackage{indentfirst}
\RequirePackage{lipsum}
\RequirePackage{xstring}
\RequirePackage{mfirstuc}
\RequirePackage{lettrine}
\RequirePackage{atveryend}
\RequirePackage{microtype}
\RequirePackage{expl3}
\RequirePackage[autostyle]{csquotes}
\RequirePackage[inline]{enumitem}
\RequirePackage{pageslts}
\RequirePackage{xcolor}
\RequirePackage{float}
\RequirePackage{xhfill}
\RequirePackage{atbegshi}
\RequirePackage{graphicx}

\RequirePackage{iftex}

\ifPDFTeX
  \RequirePackage[T1]{fontenc}
  \RequirePackage[utf8]{inputenc}
\else
  \RequirePackage{fontspec}
  \defaultfontfeatures{Ligatures=TeX}
\fi

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

\usepackage{perpage}
\MakePerPage{footnote}

% <<<1

% Margins >>>1

\notbool{strict}{
  \ifbool{fapesp}{%
    \setulmarginsandblock{3cm}{2cm}{*}
    \setlrmarginsandblock{3cm}{2cm}{*}
    \setheadfoot{\onelineskip}{2\onelineskip}
    \setheaderspaces{*}{\onelineskip}{*}
    % \setlength{\topskip}{1.6\topskip}
    \checkandfixthelayout
    \sloppybottom
  }{%
    \settypeblocksize{220mm}{*}{0.618}
    \setbinding{1cm}
    \setulmargins{*}{*}{1.618}
    \setlrmargins{*}{*}{1.618}
    \setheadfoot{\onelineskip}{2\onelineskip}
    \setheaderspaces{*}{\onelineskip}{*}
    \setlength{\topskip}{1.6\topskip}
    \checkandfixthelayout
    \sloppybottom
  }
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

% Headers and footers >>>1

\aliaspagestyle{titlingpage}{empty}

\makepagestyle{dbmheader}
\makeevenhead{dbmheader}{%
  \thepage \quad \MakeLowercase{\scshape \leftmark}%
}{}{}
\makeoddhead{dbmheader}{}{}{%
  \MakeLowercase{\scshape \rightmark} \quad \thepage%
}

% Always print footnotes in the bottom
\feetatbottom

% Hang footnote numbers in the margin
\setlength{\footmarkwidth}{-1em}
\setlength{\footmarksep}{1em}

% Increase the space between the text and the footnotes
\setfootins{1.5\bigskipamount}{\bigskipamount}

% <<<1

% Sections, chapters and parts >>>1

% Section, subsection and subsubsection >>>2

\setsecheadstyle{\normalfont\scshape\Large\MakeLowercase}
\ifbool{fapesp}{%
  \setbeforesecskip{1.2\baselineskip}
  \setaftersecskip{\baselineskip}
}{%
  \setbeforesecskip{2\baselineskip}
  \setaftersecskip{1.6\baselineskip}
}

\setsubsecheadstyle{\large\scshape\MakeLowercase}%
\ifbool{fapesp}{%
  \setbeforesubsecskip{\baselineskip}
  \setaftersubsecskip{0.6\baselineskip}
  \setsecnumdepth{subsection}
}{%
  \setbeforesubsecskip{1.6\baselineskip}
  \setaftersubsecskip{\baselineskip}
  % \setsubsecheadstyle{\sethangfrom{#1}\normalfont\small}
  \setsecnumdepth{subsection}
}


\setsubsubsecheadstyle{\Swash}
% \setsubsubsecindent{\parindent}
% \setsubsubsecindent{0pt}
\setbeforesubsubsecskip{1\baselineskip}
\setaftersubsubsecskip{.6\baselineskip}

\hangsecnum

\ifbool{section}{%
  \renewcommand{\thesection}{\arabic{section}}
  \renewcommand{\thesubsection}{\thesection.\arabic{subsection}}
  \let\l@subsection\l@section
  \let\l@section\l@chapter
}{}


% <<<2

% Chapter >>>2

% \newcommand{\openright}{\@openrighttrue\@openleftfalse%
%   \gdef\clearforchapter{\cleartorecto}}

\aliaspagestyle{chapter}{simple}

\makechapterstyle{dbmhangnum}{% >>>3
  \chapterstyle{default}
  \setlength{\beforechapskip}{50pt}
  \setlength{\afterchapskip}{25pt}
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
    \renewcommand*{\chapnamefont}{\normalfont\LARGE\scshape}
   \renewcommand*{\chaptitlefont}{\normalfont\LARGE\scshape}
    \renewcommand*{\chapnumfont}{\normalfont\LARGE\scshape}
}% <<<3

% \renewcommand\chapter{%
%   \ifartopt\par\@nameuse{chapterblock}\else
%     \clearforchapter
%     \thispagestyle{chapter}
%     \global\@topnum\z@
%   \fi
%   \m@mindentafterchapter
%   \@ifstar{\@m@mschapter}{\@m@mchapter}}

% TODO: Usar Large quando o capítulo começa na mesma
% página e HUGE quando começa sempre numa página nova.
\chapterstyle{dbmhangnum}

% <<<2

% Part >>>2

\aliaspagestyle{part}{empty}

\ifbool{resetchapters}{\@addtoreset{chapter}{part}}{}

\ifbool{paper}{%
  \renewcommand*{\parttitlefont}{\normalfont\Large\Swash}
  \renewcommand*{\partnamefont}{\normalfont\scshape\Large\MakeLowercase}
  \renewcommand*{\partnumfont}{\normalfont\scshape\Large\MakeLowercase}
}{
  \notbool{quali}{%
    \renewcommand*{\parttitlefont}{\normalfont\Large\Swash}
    \renewcommand*{\partnamefont}{\normalfont\scshape\Large\MakeLowercase}
    \renewcommand*{\partnumfont}{\normalfont\scshape\Large\MakeLowercase}
  }{%
    \renewcommand*{\parttitlefont}{\normalfont\Large\Swash}
    \renewcommand*{\partnamefont}{\normalfont\scshape\Large\MakeLowercase}
    \renewcommand*{\partnumfont}{\normalfont\scshape\Large\MakeLowercase}
  }
}

\renewcommand*{\afterpartskip}{%
  \notbool{quali}{%
    \ltx@ifpackageloaded{dbmrqminion}{%
      \vspace{30pt}
      {\HUGE\leaf}%
    }{}%
    \vfil\newpage%
  }{\vskip 50pt}
}%
\ifbool{quali}{%
  \renewcommand*{\midpartskip}{\vskip -5pt}%
}{%
  \renewcommand*{\midpartskip}{\par\vspace{50pt}}
}

% <<<2

% <<<1

% Cover and title page >>>1

% User variables >>>2

\newcommand*{\alttitle}[1]{\gdef\@alttitle{#1}}
\newcommand*{\@alttitle}{}

\newcommand*{\altsubtitle}[1]{\gdef\@altsubtitle{#1}}
\newcommand*{\@altsubtitle}{}

\newcommand*{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand*{\@subtitle}{}

\newcommand*{\cuttercode}[1]{\gdef\@cuttercode{#1}}
\newcommand*{\@cuttercode}{\textbackslash cuttercode}

\newcommand*{\university}[1]{\gdef\@university{#1}}
\newcommand*{\@university}{Universidade de São Paulo}

\newcommand*{\faculty}[1]{\gdef\@faculty{#1}}
\newcommand*{\@faculty}{Faculdade de Filosofia, Letras e Ciências Humanas}

\newcommand*{\department}[1]{\gdef\@department{#1}}
\newcommand*{\@department}{Departamento de Filosofia}

\newcommand*{\program}[1]{\gdef\@program{#1}}
\newcommand*{\@program}{Programa de Pós Graduação em Filosofia}

\newcommand*{\field}[1]{\gdef\@field{#1}}
\newcommand*{\@field}{\textbackslash field}

\newcommand*{\area}[1]{\gdef\@area{#1}}
\newcommand*{\@area}{História da Filosofia Contemporânea}

\newcommand*{\committee}[1]{\gdef\@committee{#1}}
\newcommand*{\@committee}{\textbackslash committee}

\newcommand*{\supervisor}[1]{\gdef\@supervisor{#1}}
\newcommand*{\@supervisor}{\textbackslash supervisor}

\newcommand*{\altkeywords}[1]{\gdef\@altkeywords{#1}}
\newcommand*{\@altkeywords}{\textbackslash altkeywords}

\newcommand*{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand*{\@keywords}{\textbackslash keywords}

\newcommand*{\defensedate}[1]{\gdef\@defensedate{#1}}
\newcommand*{\@defensedate}{\textbackslash defensedate}

\newcommand*{\supervisorsignature}[1]{\gdef\@supervisorsignature{#1}}
\newcommand*{\@supervisorsignature}{\textbackslash supervisorsignature}

\newcommand*{\organization}[1]{\gdef\@organization{#1}}
\newcommand*{\@organization}{%
  \@university \protect\\
  \@faculty
}

\newcommand*{\location}[1]{\gdef\@location{#1}}
\newcommand*{\@location}{São Paulo}

\ifbool{masters}{%
  \newcommand*{\goal}[1]{\gdef\@goal{#1}}
  \newcommand*{\@goal}{Mestre em \@field}
  \newcommand*{\degree}[1]{\gdef\@degree{#1}}
  \newcommand*{\@degree}{Mestrado}
  \newcommand*{\thesistype}[1]{\gdef\@thesistype{#1}}
  \newcommand*{\@thesistype}{Dissertação}
}{%
  \ifbool{thesis}{%
    \newcommand*{\goal}[1]{\gdef\@goal{#1}}
    \newcommand*{\@goal}{Doutor em \@field}
    \newcommand*{\degree}[1]{\gdef\@degree{#1}}
    \newcommand*{\@degree}{Doutorado}
    \newcommand*{\thesistype}[1]{\gdef\@thesistype{#1}}
    \newcommand*{\@thesistype}{Tese}
  }{}
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

\newcommand{\makeprojectcover}{% >>>2
  \begin{titlingpage}%
    \ifbool{project}{%
      \vspace*{\fill}
      \noindent\@author

      \noindent\@area
    }{}%
  \end{titlingpage}
}% <<<2

\newcommand{\makecover}{% >>>2
  \begin{titlingpage}%
    \ifbool{sfcover}{\sffamily}{}
    \newlength{\marginoffset}
    % \ifbool{paper}{%
      \calccentering{\marginoffset}%
    % }{%
    %   \setlength{\marginoffset}{0pt}%
    % }
    \begin{adjustwidth*}{\marginoffset}{-\marginoffset}
      \center
      {\small\ifbool{sfcover}{\sfscfamily}{\scshape}%
      \MakeUppercase{\@university}%

      \MakeUppercase{\@faculty}%

      \MakeUppercase{\@department}%

      \MakeUppercase{\@program}%
      }
      \vfill
      {\normalsize \@author}
      \vfill
      {\ifbool{sfcover}{\sffamily}{\Title}\large \textbf{\@title:}}

      \ifdefempty{\@subtitle}{}{%
        \ifbool{sfcover}{\sffamily}{\Title}\large \textbf{\@subtitle}%
      }

      % \vspace{0.6\baselineskip}

      % {\ifdefempty{\@subtitle}{}{\large \@subtitle}}
      \vfill
      \ifbool{thesis}{%
        \ifbool{corrigida}{%
          \normalsize Versão corrigida%
        }{%
          \normalsize Versão original%
        }%
        \vfill
      }{}
      {\normalsize \@location

      \@date}
    \end{adjustwidth*}
  \end{titlingpage}
}% <<<2

\newcommand{\maketitlepage}{% >>>2
  % \begin{titlingpage}%
    \thispagestyle{empty}
    \newlength{\tpmarginoffset}
    \ifbool{quali}{%
      \calccentering{\tpmarginoffset}%
    }{%
      \setlength{\tpmarginoffset}{0pt}%
    }
    \begin{adjustwidth*}{\tpmarginoffset}{-\tpmarginoffset}
      \center
      \ifbool{quali}{%
        {\large \textsc{\MakeLowercase{\@organization}}}
        \vfill
        \vfill
      }{}
      % {\small\scshape%\ifbool{sfcover}{\sfscfamily}{\scshape}
      % \MakeUppercase{\@author}}
      \@author
      \vfill
      \vfill
      % \vfill
      \vfill%
      \ltx@ifpackageloaded{dbmrqminion}{%
        {\Title\large \textbf{\@title:}}
      }{%
        {\large \textbf{\@title}}
      }

      \vspace{0.3\baselineskip}
      \ifdefempty{\@subtitle}{}{%
        \ltx@ifpackageloaded{dbmrqminion}{%
          {\Title\large \textbf{\@subtitle}}
        }{%
          {\large \textbf{\@subtitle}}
        }
      }
      \vfill
        \ifbool{corrigida}{%
          Versão corrigida%
        }{%
          Versão original%
        }%
      \ifbool{quali}{%
        \vfill
        \vspace{20pt}\par
        {\small Texto para qualificação}
        \vfill
      }{%
        \vfill
        \vspace{-20pt}
        \hspace{.5\textwidth}
        \begin{minipage}{.49\textwidth}
          \small
          \SingleSpacing
          \@thesistype\ apresentada à \@faculty\ da \@university\ para
          obtenção do título de \@goal, sob orientação do Prof. Dr.
          \@supervisor.
        \end{minipage}%
      }
      \vfill
      {\large \@location \\ \@date}
    \end{adjustwidth*}
  % \end{titlingpage}
}% <<<2

\newcommand{\makecolophon}{% >>>2
  % \begin{titlingpage}%
    \thispagestyle{empty}
    \noindent  Autorizo a reprodução e divulgação total ou parcial deste
    trabalho, por qualquer meio, convencional ou eletrônico, para fins de
    estudo e pesquisa, desde que citada a fonte.
    \vfill
    \begin{center}
    Catalogação na Publicação

    Serviço de Biblioteca e Documentação

    \@faculty\ da\ \@university
    \end{center}
    \vspace{-0.75\baselineskip}

    \begin{mdframed}
    \begin{raggedright}

      \vspace*{3.5\baselineskip}
      \@cuttercode

      \hspace*{0.15\textwidth}\begin{minipage}{0.85\textwidth}

      \begingroup
      \hyphenpenalty 10000
      \exhyphenpenalty 10000
      \hbadness=10000

      \vspace{-3.25\baselineskip}%\vspace{-2\parskip}
      \LASTFirst{\@author}

      \hspace{2em}
      \@title\ifdefempty{\@subtitle}{}{:\ \@subtitle}\ /
      \@author; orientador \@supervisor\ - \@location, \@date.

      \hspace{2em} \pageref{LastPage} p.

      \vspace{1em}

      \hspace{2em} \@thesistype\ (\@degree) - \@faculty\ da \@university.
      \@department. Área de concentração: \@field.

      \vspace{1em}

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
    \clearpage

  % \end{titlingpage}
}% <<<2

\newcommand{\makeconsent}{% >>>2
  \begin{titlingpage}%
    \ifbool{sfcover}{\sffamily}{}
    {
      \center
      {%
        \small\ifbool{sfcover}{\sfscfamily}{\scshape}%
          \MakeUppercase{\@university}%

          \MakeUppercase{\@faculty}%
          % \MakeUppercase{\@department}%
          % \MakeUppercase{\@program}%
      }

      \bigskip\bigskip\bigskip\bigskip\bigskip

      {\bfseries\Large Entrega do exemplar corrigido da dissertação}

      {\SemiBold\large Termo de ciência e concordância do orientador}

    }

    \bigskip\bigskip\bigskip\bigskip

    {\noindent\SemiBold Nome do aluno: }{\normalsize \@author}

    {\noindent\SemiBold Data da defesa: }{\normalsize \@defensedate}

    {\noindent\SemiBold Nome do orientador: }{\normalsize \@supervisor}

    \bigskip\bigskip

    \noindent Nos termos da legislação vigente, declaro \emph{estar ciente} do
    conteúdo deste \emph{exemplar corrigido} elaborado em atenção às
    sugestões dos membros da comissão julgadora na sessão de defesa do
    trabalho, manifestando-me \emph{plenamente favorável} ao seu
    encaminhamento e publicação no \emph{Portal Digital de Teses da USP}. 

    \bigskip

    \noindent São Paulo, \today

    \bigskip\bigskip

    \hfill
    \begin{minipage}[t]{15em}
      \centering% 
      \@supervisorsignature\\%
      \rule{15em}{.5pt}\\%
      (Assinatura do orientador)%
    \end{minipage}


    % \parbox[b][2.5cm][b]{20em}{%
    %   \footnotesize%Everything in footnotesize
    %   \centering% 
    %   \rule{18em}{.5pt}\\
    %   (Assinatura do orientador)
    % }


%     \begin{flushright}
%       \rule{18em}{.5pt}\\
%       (Assinatura do orientador)\hspace*{9pt}
%     \end{flushright}
  \end{titlingpage}
}% <<<2

      
\newcommand{\makealtreference}{% >>>2
  \noindent \LASTFirst{\@author}.
  \emph{\@alttitle}\ifdefempty{\@altsubtitle}{}{: \@altsubtitle}.
  \@date. \@thesistype\ (\@degree\ em \@field) -- \@faculty.
  \@department, \@university, \@location, \@date.
}% <<<2
      
\newcommand{\makereference}{% >>>2
  \noindent \LASTFirst{\@author}.
  \emph{\@title}\ifdefempty{\@subtitle}{}{: \@subtitle}.
  \@date. \@thesistype\ (\@degree\ em \@field) -- \@faculty.
  \@department, \@university, \@location, \@date.
}% <<<2

\newcommand{\parecer}{%
    Prof. Dr. \xrfill[-1.6pt]{.4pt}\hspace{.618em} Instituição: \xrfill[-1.6pt]{.4pt}

    \bigskip
    Parecer: \xrfill[-1.6pt]{.4pt}\hspace{.618em} Assinatura: \xrfill[-1.6pt]{.4pt}
}

\newcommand{\makeapproval}{% >>>2
    \begin{titlingpage}%
    \thispagestyle{empty}

    %\if@twoside%
    %  \pagestyle{empty}
    %  \newpage~\newpage~\newpage~
    %  %\setcounter{page}{2}
    %\else%
    %\fi% 

    \makereference

    \vfill

    \noindent Aprovado em: \rule[-1.6pt]{8em}{0.4pt}

    \vfill\vfill\vfill\vfill
    \center

    Banca examinadora:

    \begin{center}

    \vfill
    \parecer

    \vfill
    \parecer

    \vfill
    \parecer

    \vfill
    \parecer

    % \vfil
    % \parecer

    \end{center}
    \end{titlingpage}%
}% <<<2

% Thanks >>>2

\renewcommand{\thanks}[1]{\gdef\@thanks{#1}}
\renewcommand{\@thanks}{\lipsum[1-4]}
\newcommand{\makethanks}{%
  \chapter{Agradecimentos}
  \@thanks%
  \cleardoublepage
}%

% <<<2

% Epigraph >>>2

\renewcommand{\epigraph}[1]{\gdef\@epigraph{#1}}
\newcommand{\@epigraph}{\lipsum[1]}

\newcommand{\makeepigraph}{
  \thispagestyle{empty}
  \addcontentsline{toc}{chapter}{Epígrafe}
  \vspace*{\fill}
  \hfill
  \begin{minipage}{.618\textwidth}

  \abnormalparskip{0.7\baselineskip}%

  \@epigraph

  \end{minipage}
  \cleardoublepage
}

% <<<2

% Abstract >>>2

\newcommand{\resumo}[1]{\gdef\@resumo{#1}}
\newcommand{\@resumo}{\lipsum[2]}

\renewcommand{\abstract}[1]{\gdef\@abstract{#1}}
\newcommand{\@abstract}{\lipsum[2]}

\newcommand{\makeabstract}{
  \begin{Spacing}{1.4}
  \chapter{Resumo}
  \makereference

  \vspace{.5\baselineskip}

  \noindent
  % \ltx@ifpackageloaded{dbmrqminion}{%
  %   {\SemiBold Resumo:}
  % }{%
  %   \textbf{Resumo:}
  % }
  \@resumo

  \vspace{.5\baselineskip}

  \noindent
  \ltx@ifpackageloaded{dbmrqminion}{%
    {\SemiBold Palavras chave:}
  }{%
    \textbf{Palavras chave:}
  }
  \StrBefore{\@keywords}{,}, \StrBetween[1,2]{\@keywords}{,}{,},
  \StrBetween[2,3]{\@keywords}{,}{,}, \StrBetween[3,4]{\@keywords}{,}{,},
  \StrBehind[4]{\@keywords}{,}.
  \vspace{\baselineskip}
  \cleardoublepage

  % \clearpage

  \chapter{Abstract}
  \makealtreference

  \vspace{.5\baselineskip}

  \noindent
  % \ltx@ifpackageloaded{dbmrqminion}{%
  %   {\SemiBold Abstract:}
  % }{%
  %   \textbf{Abstract:}
  % }
  \@abstract

  \vspace{.5\baselineskip}

  \noindent
  \ltx@ifpackageloaded{dbmrqminion}{%
    {\SemiBold Keywords:}
  }{%
    \textbf{Keywords:}
  }
  \StrBefore{\@altkeywords}{,}, \StrBetween[1,2]{\@altkeywords}{,}{,},
  \StrBetween[2,3]{\@altkeywords}{,}{,},
  \StrBetween[3,4]{\@altkeywords}{,}{,}, \StrBehind[4]{\@altkeywords}{,}.
  \cleardoublepage
  \end{Spacing}
}

% <<<2

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
\newlist{inlinalt}{enumerate*}{1}
\setlist*[inlinalt,1]{%
  before={ ou\ }, label=(\arabic*), itemjoin={{, ou }}%
}
\newlist{inlinin*}{enumerate*}{1}
\setlist*[inlinin*,1]{%
  label=(\arabic*), itemjoin={{; }}, itemjoin*={{ e }}%
}
\newlist{inlinex*}{enumerate*}{1}
\setlist*[inlinex*,1]{%
  label=(\arabic*), itemjoin={{; }}, itemjoin*={{ ou }}%
}
\newlist{inlinalt*}{enumerate*}{1}
\setlist*[inlinalt*,1]{%
  before={ ou\ }, label=(\arabic*), itemjoin={{; ou }}%
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

% TOC >>>1

% Simple TOC >>>2

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
\maxtocdepth{section}
\setlength{\cftparskip}{0.2\baselineskip}

\setlength{\cftbeforepartskip}{1.5\baselineskip}
\renewcommand{\cftpartfont}{\large}
\renewcommand{\cftpartleader}{}
\renewcommand{\cftpartafterpnum}{\cftparfillskip}
\cftsetindents{part}{1.5em}{0em}
\renewcommand{\partnumberline}[1]{}
\cftpagenumbersoff{part}

% This is necessary so that hyperref and \MakeLowercase play well
% \settocpreprocessor{chapter}{%
%   \let\tempf@rtoc\f@rtoc%
%   \def\f@rtoc{%
%     \texorpdfstring{\MakeTextLowercase{\tempf@rtoc}}{\tempf@rtoc}}%
% }

\setlength{\cftbeforechapterskip}{.5\baselineskip}
\renewcommand{\cftchapterfont}{\normalsize\bfseries}
\renewcommand{\cftchapterpresnum}{\hspace*{-1.5em}}
\cftsetindents{chapter}{1.5em}{0em}
\renewcommand{\cftchapterleader}{\hspace{.5em}}
\renewcommand{\cftchapterafterpnum}{\cftparfillskip}

\renewcommand{\cftsectionfont}{\small\bfseries}
\cftsetindents{section}{1.5em}{2.3em}
\renewcommand{\cftsectionleader}{}
\renewcommand{\cftsectionafterpnum}{\cftparfillskip}

\renewcommand{\cftsubsectionfont}{\small}
\cftsetindents{subsection}{3.8em}{2em}
\renewcommand{\cftsubsectionleader}{}
\renewcommand{\cftsubsectionafterpnum}{\cftparfillskip}
% \setlength{\cftsubsectionnumwidth}{0}


\renewcommand{\cftsectionpagefont}{\small\bfseries\color{black!61}}
\renewcommand{\cftchapterpagefont}{\cftsectionpagefont}
\renewcommand{\cftsubsectionpagefont}{\cftsectionpagefont}

% <<<1

% Misc >>>1

\newif\ifstartblanks@nextblank

\newcommand*\startblanks@blanks{}%
\let\startblanks@blanks\relax
\newcommand*\startblanks{%
  \global\startblanks@nextblanktrue
  \gdef\startblanks@blanks%
    {%
      \ifstartblanks@nextblank
        \thispagestyle{empty}%
        % \addtocounter{page}{-1}%
        \mbox{}%
        \clearpage
        \global\startblanks@nextblankfalse
      \else
        \global\startblanks@nextblanktrue
      \fi
    }%
  \AtBeginShipout{\startblanks@blanks}
}
\newcommand*\stopblanks{%
  \global\let\startblanks@blanks\relax
}

\newcommand{\clearemptydoublepage}{%
  \if@twoside%
    {\null\newpage\thispagestyle{empty}}
    {\null\newpage\thispagestyle{empty}}
    \cleartooddpage[\thispagestyle{empty}]
  \else
    \clearpage
  \fi%  
}

\newbool{final}
\notbool{quali}{\booltrue{final}}{}

\RequirePackage{environ}
\NewEnviron{quali}{\ifbool{quali}{\BODY}{}}
\NewEnviron{notquali}{\notbool{quali}{\BODY}{}}
\NewEnviron{final}{\notbool{quali}{\BODY}{}}

\clubpenalty=9996
\widowpenalty=9999
\brokenpenalty=4991
\predisplaypenalty=10000
\postdisplaypenalty=1549
\displaywidowpenalty=1602
\doublehyphendemerits=640000

\setlength{\parindent}{2em}

\abnormalparskip{0.3\baselineskip}%

\raggedbottom

% <<<1

\AtEndPreamble{% >>>1

  \ltx@ifpackageloaded{biblatex}{%

    \defbibheading{bibliography}[\refname]{% >>>2
      \def\clearpage{\newpage \write\m@ne{}\vbox{}\penalty -\@Mi}
      \clearpage
      \emergencystretch=1em
      \SingleSpacing
      \chapter*{#1}%
      \ifmemoirbibintoc
        {\phantomsection
        \addcontentsline{toc}{chapter}{#1}}
        {}%
      \markboth{\memUChead{#1}}{\memUChead{#1}}}% <<<2

    \defbibheading{subbibliography}[\refname]{% >>>2
      \section*{#1}%
      % \ifmemoirbibintoc
      %   {\phantomsection
      %   \addcontentsline{toc}{section}{#1}}
      %   {}%
      \if@twoside\markright{\memUChead{#1}}\fi}% <<<2

    \defbibheading{subsubbibliography}[\refname]{% >>>2
      \subsection*{#1}%
      % \ifmemoirbibintoc
      %   {\phantomsection
      %   \addcontentsline{toc}{section}{#1}}
      %   {}%
      \if@twoside\markright{\memUChead{#1}}\fi}% <<<2

    \defbibheading{subsubsubbibliography}[\refname]{% >>>2
      \subsubsection*{#1}%
      % \ifmemoirbibintoc
      %   {\phantomsection
      %   \addcontentsline{toc}{section}{#1}}
      %   {}%
      \if@twoside\markright{\memUChead{#1}}\fi}% <<<2

    \renewcommand*{\bibnameunderscore}{%
      \rule[-1pt]{3em}{0.75pt}%
    }

    \bibhang 1em
    \setlength{\shorthandwidth}{3em}

    \DeclareBibliographyCategory{singleentries}
    \newcommand{\singlecite}[1]{%
      \addtocategory{singleentries}{#1}%
      \defbibcheck{key#1}{
        \iffieldequalstr{entrykey}{#1}{}{%
          \skipentry%
        }%
      }%
      \printbibliography[heading=none,check=key#1]%
    }

  }{}

\RequirePackage[plainpages=false,linktoc=all]{hyperref}
% This is necessary so chapters with the same numbers (on different parts)
% will be referenced properly:
\renewcommand*{\theHchapter}{\thepart.\thebook.\thechapter}

}% <<<1

\AfterEndPreamble{% >>>1
  % For some reason I get errors if this stuff is \AtBeginDocument

  \frontmatter

  \pagestyle{simple}
  % \pagestyle{dbmheader}

  \ifbool{paper}{\makecover}{}
  \ifbool{project}{\makeprojectcover}{}

  \ifbool{thesis}{% >>>2
    \SingleSpacing

    \nouppercaseheads


    \notbool{quali}{%
      \notbool{hardcover}{%
        \makecover
        \clearpage
      }{}
    }{}

    \maketitlepage
    \clearpage

    \notbool{quali}{%

      % \afterpage{\repeatafter}

      \makecolophon
      % \clearpage
      \ifbool{corrigida}{\makeconsent}{}%
      % \clearpage
      \makeapproval
      % \clearpage
      \makethanks
      % \clearpage
      \makeepigraph
      % \clearpage
      \makeabstract
      % \clearpage
      % \afterpage{}
    }{}

    % \clearpage
    \if@twoside%
      \startblanks
      \pagestyle{empty}
      \tableofcontents*
      \stopblanks
      \cleardoublepage
    \else
      \pagestyle{empty}
      \tableofcontents*
    \fi% 

  }{}% <<<2

  \mainmatter
  \pagestyle{simple}

  \ifbool{strict}{%
    \ifbool{fapesp}{%
      \begin{Spacing}{2.0}
    }{%
      \begin{Spacing}{1.5}
    }
  }{%
    \ifbool{fapesp}{%
      \begin{Spacing}{1.8}
    }{%
      \ifbool{quali}{%
        \begin{Spacing}{1.8}
      }{%
        \begin{Spacing}{1.4}
      }
    }
  }

  \ifbool{project}{%
    % \begin{center}
    {\HUGE\bfseries
     \noindent\@title\ifdefempty{\@subtitle}{\vspace*{2em}}{:\vspace*{5pt}}
     \thispagestyle{empty}}\\
      \ifdefempty{\@subtitle}{}{%
        {\HUGE\bfseries \@subtitle}\vspace*{2em}\\
      }
    {\large\today}%\vspace{1em}%
    % \end{center}
  }{}

}% <<<1

\AtBeginDocument{% >>>1

\ltx@ifpackageloaded{biblatex}{%
  \addto\extrasbrazil{%
    \renewcommand{\chapterautorefname}{capítulo}%
    \renewcommand{\sectionautorefname}{seção}%
    \renewcommand{\partautorefname}{parte}%
  }
}{}

\frenchspacing

}% <<<1

\AtEndDocument {% >>>1

\end{Spacing}

}% <<<1

% \AfterLastShipout {% >>>1
% Unfortunately this messes up the number of pages

% \notbool{nobib}{%
%   \ltx@ifpackageloaded{biblatex}{%
%     % \clearpage
%     \emergencystretch=1em
%     \SingleSpacing
%     \printbibliography
%   }
% }{}

% }% <<<1

