%%% REBEKAH IGNORE THIS SECTION

\version "2.19.12"
\include "predefined-guitar-fretboards.ly"

#(define pcvector '(2 . 12))

#(set! paper-alist (cons '("half letter" . (cons (* 5.5 in) (* 8.5 in))) paper-alist))
#(set! paper-alist (cons '("projector" . (cons (* 16 in) (* 9 in))) paper-alist))
#(set! paper-alist (cons '("hymn" . (cons (* 6 in) (* 9 in))) paper-alist))

\paper {
  
  print-page-number = ##f

  top-margin = 0.35\in
  bottom-margin = 0.3\in
  left-margin = 0.44\in
  right-margin = 0.44\in
  
}
#(set-default-paper-size "hymn")
#(set-global-staff-size 13.4)

%%%
%%% REBEKAH START HERE
%%%

\header {
  title = "All Hail the Power of Jesus' Name"
}

global = {
  \key g \major
  \time 4/4
  \numericTimeSignature
  \set Timing.beamExceptions = #'() % REBEKAH IGNORE
}


sopranoMusic = \relative c' { 
\partial 4
d4 g g b b a g a b a g b a g2. \bar ""
a4 b a g b d8( c) b( a) b4 d d2 d e d4( cis) d2. \bar ""
b4 d b g b a8( g) a( b) a4 g d'2 c b4.( c8 a4) a g2. 
\bar "|."
  
}
sopranoMusicRefrain = \relative c' {
}
altoMusic = \relative c' { 
d4 d d g g fis e fis g fis g g fis d2. 
d4 g d b g' b8( a) g( fis) g4 fis g2 a g fis4( e) fis2. 
d4 d d d g fis8( e) fis( g) fis4 g g2 e d2. fis4 d2. 
}
altoMusicRefrain = \relative c' { 
}
tenorMusic = \relative c { 
d4 g b d d d b d d c b d c b2. 
a4 b a g b d8( c) b( a) b4 a b2 a b a a2. 
g4 b g g d' d d d b g2 g g4.( a8 fis a) c4 g2. 
}
tenorMusicRefrain = \relative c' { 
}
bassMusic = \relative c {
d4 b g g' g d e d g d e d d g,2. 
d'4 g d b g' b8( a) g( fis) g4 d g2 fis e a d,2. 
g4 g g, b g d' d d e b2 c d2. d4 g,2.
}
bassMusicRefrain = \relative c { 
  
}
%%%%% LYRICS: %%%%%%
stanzaOne = \lyricmode {
  \set stanza = "1." 
  All hail the pow’r of Je -- sus’ name! Let an -- gels pros -- trate fall.
  Bring forth the roy -- al di -- a -- dem, And crown Him Lord of all;
  Bring forth the roy -- al di -- a -- dem, And crown Him Lord of all!
}
stanzaTwo = \lyricmode {
  \set stanza = "2."
  Ye cho -- sen seed of Is -- rael’s race, Ye ran -- somed from the fall,
  Hail Him who saves you by His grace, And crown Him Lord of all;
  Hail Him who saves you by His grace, And crown Him Lord of all!
  
}
stanzaThree = \lyricmode {
  \set stanza = "3."
  Let ev -- ’ry kin -- dred, ev -- ’ry tribe On this ter -- res -- trial ball
  To Him all maj -- es -- ty as -- cribe, And crown Him Lord of all;
  To Him all maj -- es -- ty as -- cribe, And crown Him Lord of all!
}
stanzaFour = \lyricmode {
  \set stanza = "4."
  O that with yon -- der sa -- cred throng We at His feet may fall! 
  We’ll join the ev -- er -- last -- ing song And crown Him Lord of all;
  We’ll join the ev -- er -- last -- ing song And crown Him Lord of all!
}
refrain = \lyricmode {

}
%REBEKAH: UNHIDE EXTRA STANZAS BELOW

chordMusic = \chordmode {
  d4 g/b g2. d4 e:m d g d e:m g/d d:7 g2.
  d4 g d g/b g g2. d4 g2 d/fis e:m d4/a a d2. 
  g4 g2 g4/b g d2. e4:m g2/b c g2/d d:7 g2.
}
%%%REBEKAH IGNORE:
chordNames = \chordmode { 
    \chordMusic
}
fretBoards = \chordmode { 
    \chordMusic
}
chordNamesStaff = \new ChordNames {
  \chordNames
}
fretBoardsStaff = \new FretBoards {
  \fretBoards
}


aligner = { \sopranoMusic \sopranoMusicRefrain }

%aligner = { \override Staff.ParenthesesItem.stencil = ##f \sopranoMusic \sopranoMusicRefrain}
%REBEKAH: CAN HIDE/UNHIDE THE BELOW WITH "%"
#(define showChordNamesStaff "hi")
%#(define showFretBoardsStaff "hi")

\score {
  <<
    #(cond ((defined? 'showChordNamesStaff) chordNamesStaff))
    #(cond ((defined? 'showFretBoardsStaff) fretBoardsStaff))
    
    \new Staff <<
      \global
      \new Voice = "sa" {
        \partcombine \pcvector \sopranoMusic \altoMusic
        \partcombine \pcvector \sopranoMusicRefrain \altoMusicRefrain
      }
      \new NullVoice = "aligner" {
        \aligner
      }
    >>


    %UNHIDE STANZAS HERE - IF NO REFRAIN, REMOVE FROM STANZA 2
    \new Lyrics \lyricsto "aligner" \stanzaOne 
    \new Lyrics \lyricsto "aligner" {\stanzaTwo}
    \new Lyrics \lyricsto "aligner" \stanzaThree
    \new Lyrics \lyricsto "aligner" \stanzaFour
   
   %%%
%%% REBEKAH STOP HERE
%%%
   
    \new Staff {
      \global
      \clef "bass"
      \partcombine \pcvector \tenorMusic \bassMusic
      \partcombine \pcvector \tenorMusicRefrain \bassMusicRefrain
    }
  >>

\midi {}

\layout {
  indent = 0
  \context {
    \Score
    \omit BarNumber
    \accepts NashvilleNumbers
  }
  \context {
    \Lyrics
    % Prevents lyrics from running too close together
    \override LyricSpace.minimum-distance = #0.6
    % Enforces hyphens
    \override LyricHyphen.minimum-distance = #1.0
    % Makes the text of lyrics a little smaller
    \override LyricText.font-size = #0.75
    % Makes the stanza number medium weight
    \override StanzaNumber.font-series = #'medium
    % Moves lines of lyrics a little closer together
    \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #2.5
  }
  \context {
    \ChordNames
    % Changes chord name font to roman instead of sans
    \override ChordName.font-family = #'roman
    % Shrinks default font size of chord names
    \override ChordName.font-size = #0
    % Adds the stanza number engraver (for Capo labels)
    \consists "Stanza_number_engraver"
    % Center-aligns the ChordName
    %\override ChordName.X-offset = #ly:self-alignment-interface::aligned-on-x-parent
    %\override ChordName.self-alignment-X = #CENTER
  }
  \context {
    \Staff
    % Thin out the staff line thickness a little bit
    % (keep in mind other element thicknesses are based on this measurement)
    \override StaffSymbol.thickness = #0.75
    % The thicker of two lines in a bar line
    \override BarLine.thick-thickness = #4.5
    % The thinner of two lines in a bar line (or a regular measure line)
    \override BarLine.hair-thickness = #1.5
    % Don't print the default partcombine text ("a2", etc)
    \override Staff.printPartCombineTexts = ##f
  }
}


}