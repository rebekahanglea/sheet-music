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
  title = "Title"
}

global = {
  \key g \major
  \numericTimeSignature
\time 12/8
  \set Timing.beamExceptions = #'() % REBEKAH IGNORE
}


sopranoMusic = \relative c'' { 
  
}
sopranoMusicRefrain = \relative c' {
}
altoMusic = \relative c' { 
  
}
altoMusicRefrain = \relative c' { 
}
tenorMusic = \relative c' { 
  
}
tenorMusicRefrain = \relative c' { 
}
bassMusic = \relative c' {
  
}
bassMusicRefrain = \relative c { 
  
}

stanzaOne = \lyricmode {
  \set stanza = "1." 
}
stanzaTwo = \lyricmode {
  \set stanza = "2."
}
stanzaThree = \lyricmode {
  \set stanza = "3."
}
stanzaFour = \lyricmode {
  \set stanza = "4."
}
refrain = \lyricmode {

}
%REBEKAH: UNHIDE EXTRA STANZAS BELOW

chordMusic = \chordmode {
  e:m a:m
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
    %\new Lyrics \lyricsto "aligner" {\stanzaTwo \refrain}
    %\new Lyrics \lyricsto "aligner" \stanzaThree
    %\new Lyrics \lyricsto "aligner" \stanzaFour
   
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

}

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
\midi {}

