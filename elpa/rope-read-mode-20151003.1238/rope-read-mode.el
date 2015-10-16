;;; rope-read-mode.el --- Rearrange lines to read text smoothly

;;; Header:

;; Copyright 2015 Marco Wahl

;; Author: Marco Wahl <marcowahlsoft@gmail.com>
;; Maintainer: Marco Wahl <marcowahlsoft@gmail.com>
;; Created: 4 Jan 2015
;; Version: 0.3.1
;; Package-Version: 20151003.1238
;; Keywords: reading, convenience
;; URL: https://github.com/marcowahl/rope-read-mode

;; This file is not part of Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; ** Generate the README.md

;; 1. View this file in org-mode via lentic.
;; 2. Export the section Commentary as markdown into a buffer.
;; 3. Save the buffer as README.md.

;;; Commentary:

;; ** What rope-read-mode is

;; =rope-read-mode= reverses every other line in a part of a buffer.
;; When every other line has been reversed reading is like following a
;; rope.

;; *** Illustration

;; [[file:rope-read-illustration.png][file:./rope-read-illustration.png]]

;; *** Benefits

;; - Chill.  =rope-read-mode= often allows fluent reading by finding the
;;   start of the next line easily.
;; - Have an alternative view on text.

;; *** Price

;; Typically you need to invest some time to learn to read upside-down
;; lines easily.

;; ** Usage

;; Type =M-x rope-read-mode= in a buffer and see how the transformation
;; performs starting from the cursor position (aka as 'point').

;; Interrupt =rope-read-mode= any time with =C-g=.  Type =M-x
;; rope-read-mode= again or press 'q' to leave the mode.

;; When =rope-read-mode= is active you can use any method to reach a
;; location of interest followed by a press on 'g' to trigger a refresh
;; of the view.

;; In =rope-read-mode= you can use:

;; - q to quit.
;; - SPC / <backspace> S-SPC to scroll a screen.
;; - v <return> / V y to scroll one line.
;; - g to refresh rope read.
;; - ? to open the help buffer.

;; For convenience command rope-read-mode can be bound to a key
;; sequence.  For example to activate or deactivate rope-read-mode by
;; pressing scroll lock two times use the line

;; #+BEGIN_EXAMPLE
;; (global-set-key (kbd "<Scroll_Lock> <Scroll_Lock>") 'rope-read-mode)
;; #+END_EXAMPLE

;; *** Image files

;; The reverse representation of lines is realized with images.  They get
;; collected in directory =rope-read-image-overlay-path=.  You can delete
;; this directory any time.

;; *** Security

;; =rope-read-mode= does not change the content of a buffer.  In the
;; sense of data loss =rope-read-mode= is perfectly save.

;; Note that the overlay-image files get stored on disk.  This could be a
;; security issue.

;; ** Install

;; *** Emacs Package

;; When installed as Emacs package
;; [[http://melpa.org/#/rope-read-mode][file:http://melpa.org/packages/rope-read-mode-badge.svg]] then there is
;; no need of a special configuration.

;; *** Install from el file

;; If you just have the emacs-lisp file then:
;; - load the file into Emacs
;; - do =M-x eval-buffer=

;; That's it.  You installed rope-read-mode and =M-x rope-read-mode= is
;; available.

;; ** Dependencies

;; - Emacs is running under X.
;; - The programm =convert= of the ImageMagick-suite is available.

;; The =convert= program has the job to create images of lines and rotate
;; them.

;; ** Development

;; *** Known Bugs

;; - rope-read-mode sometimes spontaneously fails.
;;   - In this case a refresh with 'g' might help.
;;   - You can always try 'C-g q' and start again.
;; - rope-read-mode often does not work for org-mode files.
;;   - Possibly this is due to the interference of overlays of org and
;;     rope-read.

;; *** Wishes

;; - Quicker transformation.

;; *** Vision

;; rope-read-mode gets rope-mode which allows also editing.  rope-mode
;; would provide a further possibility for the user to use Emacs, just as
;; changing the default font.

;; *** Lentic Literate Style

;; This program is written in emacs lisp in lentic style based on the
;; 'lentic' package [[http://melpa.org/#/lentic][file:http://melpa.org/packages/lentic-badge.svg]].

;; This means the that this file can be regarded just as an emacs lisp
;; file.  But actually this file contains extra comments which allow the
;; interpretation of the file as Org file.  Lentic-mode makes it easy to
;; write this style.

;; A possible initialization of lentic is this:

;; #+BEGIN_EXAMPLE
;; (global-lentic-start-mode)
;; #+END_EXAMPLE

;; Find more about lentic at
;; [[http://melpa.org/#/lentic][file:http://melpa.org/packages/lentic-badge.svg]].

;; *** Communication

;; Use the GitHub infrastructure i.e. pull requests or
;; https://github.com/marcowahl/rope-read-mode/issues.  Or contact the
;; author directly.

;; *** Contribution

;; Contributions in any respect are welcome, e.g. ideas and improvements.

;; *** Contributors

;; | Syohei YOSHIDA |
;; | Marco WAHL     |

;; ** Links

;; - rope-read for firefox at
;;   https://greasyfork.org/en/scripts/10634-rope-read
;; - 'spray' which is available as Elpa package
;;   [[http://melpa.org/#/spray][file:http://melpa.org/packages/spray-badge.svg]] realizes another
;;   alternative view mode.
;; - 'fliptext' which also is available as Elpa package
;;   [[http://melpa.org/#/fliptext][file:http://melpa.org/packages/fliptext-badge.svg]] realizes an

;;   ˙ʇxǝʇ pǝddılɟ ɹoɟ poɥʇǝɯ-ʇnduı

;; ** History

;; | 201501151211 | v0.1 New option rope-read-calculate-exact-y-coordinates |
;; | 201501311657 | v0.2 Replace whenever a line is ready                   |
;; | 201503160841 | Dropped option heuristic y-coordinates calculation      |
;; | 201503161010 | v0.3 Operations based on visual movement-commands       |
;; | 201508081255 | v0.3.1 rope-read-mode starts line reversing at point     |

;;; Code:

;; ** Variables

;; #+BEGIN_SRC emacs-lisp
(defvar rope-read-overlays nil
  "List of rope-read-overlays.")

(defvar rope-read-olimid-next-unused 0
  "Overlay-image-id that has not been used yet.

  The program must reset this variable reasonably when an id gets
  used.")

(defvar rope-read-image-overlay-path "~/.emacs.d/rope-reading/"
  "Path where the overlay images get stored.")

(defvar rope-read-image-overlay-filename-format-string
  (concat (file-name-directory rope-read-image-overlay-path) "%d.png")
  "Template for the filenames to be written to disk.")

(defvar rope-read-mode nil)
(make-variable-buffer-local 'rope-read-mode)

(defvar rope-read-old-buffer-read-only)
(make-variable-buffer-local 'rope-read-old-buffer-read-only)
;; #+END_SRC

;; ** Keys

;; #+BEGIN_SRC emacs-lisp
(defvar rope-read-mode-hook nil)

(defvar rope-read-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map " " 'rope-read-next-page)
    (define-key map [?\S-\ ] 'rope-read-prev-page)
    (define-key map (kbd "<backspace>") 'rope-read-prev-page)
    (define-key map (kbd "<return>") 'rope-read-scroll-up-line)
    (define-key map "v" 'rope-read-scroll-up-line)
    (define-key map "y" 'rope-read-scroll-down-line)
    (define-key map "V" 'rope-read-scroll-down-line)
    (define-key map "g" 'rope-read-refresh)
    (define-key map "q" 'rope-read-quit)
    (define-key map "?" 'describe-mode)
    map)
  "Keymap for rope-read-mode.")
;; #+END_SRC

;; #+BEGIN_SRC emacs-lisp
(defvar rope-read-transform-fun
  ;; #'rope-read-reol-in-visible-buffer-part-with-images
  #'rope-read-reol
  "The function which transforms a screen for rope-reading.

This indirection is for the comfort of any coder to try
out something new.")
;; #+END_SRC

;; ** Mode rope-read

;; #+BEGIN_SRC emacs-lisp
;;;###autoload
(define-minor-mode rope-read-mode
  "Rope Reading mode.

In rope-read-mode every other line gets reversed.  rope-read-mode is a
view only mode.

\\{rope-read-mode-map}

This mode can help to save eye movements.

By reversing every other line the reader often just can dip the
gaze at the end of a line to read on instead of doing the
annoying search for the next line at the other side of the text."
  :lighter " rope-read" :keymap rope-read-mode-map
  (if rope-read-mode (rope-read-mode-enable) (rope-read-mode-disable)))

(defun rope-read-mode-enable ()
  (unless (file-exists-p rope-read-image-overlay-path)
    (make-directory rope-read-image-overlay-path))
  (setq rope-read-old-buffer-read-only buffer-read-only
        buffer-read-only t)
  (funcall rope-read-transform-fun)
  (run-hooks 'rope-read-mode-hook))

(defun rope-read-mode-disable ()
  (rope-read-delete-overlays)
  (setq buffer-read-only rope-read-old-buffer-read-only))
;; #+END_SRC

;; ** Management and Navigation

;; #+BEGIN_SRC emacs-lisp
(defun rope-read-delete-overlays ()
  "Delete all overlays currently used with the rope-read-feature."
  (interactive)
  (mapc #'delete-overlay rope-read-overlays)
  (setq rope-read-overlays nil))

(defun rope-read-next-page ()
  (interactive)
  (rope-read-delete-overlays)
  (scroll-up-command)
  (redisplay t)
  (move-to-window-line 0)
  (funcall rope-read-transform-fun))

(defun rope-read-prev-page ()
  (interactive)
  (rope-read-delete-overlays)
  (scroll-down-command)
  (redisplay t)
  (move-to-window-line 0)
  (funcall rope-read-transform-fun))

(defun rope-read-scroll-line (n)
  "Scroll the buffer N lines and reverse every other visible line."
  (rope-read-delete-overlays)
  (scroll-up-line n)
  (redisplay t)
  (move-to-window-line 0)
  (funcall rope-read-transform-fun))

(defun rope-read-scroll-up-line (n)
  "Scroll the buffer up N lines and reverse every other visible line.

  E.g.  for N = 1 the second-line becomes first."
  (interactive "p")
  (unless n (setq n 1))
  (rope-read-scroll-line n))

(defun rope-read-scroll-down-line (n)
  "Scroll the buffer down N lines and reverse every other line.

  E.g.  for N = 1 the first-line becomes second."
  (interactive "p")
  (unless n (setq n 1))
  (rope-read-scroll-line (- n)))

(defun rope-read-refresh ()
  "Refresh the rope-read-representation for the given window."
  (interactive)
  (rope-read-delete-overlays)
  (redisplay t)
  (move-to-window-line 0)
  (funcall rope-read-transform-fun))

(defun rope-read-quit ()
  (interactive)
  (when rope-read-mode (rope-read-mode 'toggle)))
;; #+END_SRC

;; ** Y-coordinates of a line

;; *** Exact y-coordinate calculation of a line

;; This function calculates the y-coordinates straightforward.  This
;; function takes a lot of time.

;; #+BEGIN_SRC emacs-lisp
(defun rope-read-y-info-of-line ()
  "Return the top coordinate and the height of the line that contains `(point)'.
This function typically takes a while."
  (let* ((beg (progn (beginning-of-visual-line) (point)))
         (posn-at-point
          (progn
            (posn-at-point (point))))
         (y-top (cdr (posn-x-y posn-at-point)))
         (height (cdr (nth 9 posn-at-point)))
         (end (progn (end-of-visual-line) (point))))
    (goto-char beg)
    (while (and (< (point) (point-max))
                (progn (forward-char)
                       (< (point) end)))
      (setq
       posn-at-point (posn-at-point (point))
       height (max height (cdr (nth 9 posn-at-point)))
       y-top (min y-top (cdr (posn-x-y posn-at-point)))))
    (cons y-top height)))
;; #+END_SRC

;; *** TODO Try to speed up the function

;; Try to answer first: Is the speed up possible?

;; ** Reverse every other line

;; #+BEGIN_SRC emacs-lisp
(defun rope-read-reol-in-visible-buffer-part-with-images ()
  "Reverse every other line in the visible buffer part."
  (move-to-window-line 0)
  (rope-read-reol))
;; #+END_SRC

;; #+BEGIN_SRC emacs-lisp
(defun rope-read-advance-one-visual-line ()
  (beginning-of-visual-line 2))

(defun rope-read-reol ()
  "Reverse every other line in the visible part starting with line after point."
  (interactive)
  (save-excursion
    (let ((point-at-start (point))
          (last-line
           (progn (move-to-window-line -1)
                  (point))))
      (goto-char point-at-start)
      (beginning-of-visual-line)
      (rope-read-advance-one-visual-line)
      (while (and (< (point) last-line) ; todo: handle case of last line
                  (< (save-excursion (end-of-visual-line) (point))
                     (point-max))) ; todo: try to handle also the very
                                        ; last line.  the last line is
                                        ; special because it is
                                        ; special for the
                                        ; beginning-of-visual-line
                                        ; command.  no further
                                        ; iteration!
        (rope-read-snap-visual-line-under-olimid-filename)
        (let* ((l-above (save-excursion (beginning-of-visual-line 0) (point)))
               (l-beg   (save-excursion (beginning-of-visual-line) (point)))
               (l-end   (save-excursion (end-of-visual-line) (point)))
               (l-next  (save-excursion
                          (goto-char l-beg) (beginning-of-visual-line 2) (point)))
                                        ; try to use for identify truncation of the line
               (olimid-current (1- rope-read-olimid-next-unused)))
          (push (make-overlay l-beg l-end) rope-read-overlays)
          (overlay-put
           (car rope-read-overlays) 'display
           (create-image
            (expand-file-name
             (format 
              rope-read-image-overlay-filename-format-string
              olimid-current))
            nil nil
            :ascent 'center
            ;; TODO: try to refine.  hint: try
            ;; understand.  is this a font-dependent
            ;; thing?  e.g. :ascent 83 is possible.
            ;; there are further attributes...
            ))
          (when (= l-end l-next)
            (overlay-put (car rope-read-overlays) 'after-string "\n")
            ;; this newline makes the images appear in some cases.
            ;; todo: at least think about doing something similar in
            ;; the analog case of 'before'.
            )
          (goto-char l-next)
          (redisplay t)
          (rope-read-advance-one-visual-line))))))
;; #+END_SRC

;; ** Snap the line which contains point

;; For testing: (local-set-key (kbd "<f8>")
;; 'rope-read-snap-visual-line-under-olimid-filename)

;; #+BEGIN_SRC emacs-lisp
(defun rope-read-snap-visual-line-under-olimid-filename ()
  "Snapshot the visual line with `(point)' flipflopped.

Also consider the line above the line containing `(point)'.  If
the line above is longer then extend the snapshot to use the
length of the line above.  This often eases continuation of
reading for short lines.

The file name for the snapshot contains the number
`rope-read-olimid-next-unused' as index.  Use the source for all
detail."
  (interactive "P")
  (save-excursion
    (let* ((beg (progn (beginning-of-visual-line) (point)))
           (end (progn (end-of-visual-line) (point)))
           (end-above (save-excursion (goto-char beg) (end-of-visual-line 0) (point)))
           (beg-next (progn  (goto-char beg) (beginning-of-visual-line 2) ))
           (width (if (or (= end beg-next) (= end-above beg))
                      (- (nth 2 (window-inside-pixel-edges))
                         (nth 0 (window-inside-pixel-edges)))
                    (- (max (car (posn-x-y (posn-at-point end)))
                            (car (posn-x-y (posn-at-point end-above))))
                       (car (posn-x-y (posn-at-point beg))))))
           (y-info-getter #'rope-read-y-info-of-line)
           (y-top-height (progn (goto-char beg)
                                (funcall y-info-getter)))
           (y-pos-line (car y-top-height))
           (height (cdr y-top-height))
           (x-win-left (nth 0 (window-inside-pixel-edges)))
           (y-win-top (nth 1 (window-inside-pixel-edges)))
           (x-anchor (+ x-win-left))
           (y-anchor (+ y-win-top y-pos-line)))
      (call-process
       "convert" nil nil nil
       (format "x:%s[%dx%d+%d+%d]"
               (frame-parameter nil 'window-id)
               width height x-anchor y-anchor)
       "-flip"
       "-flop"
       (expand-file-name
        (format
         rope-read-image-overlay-filename-format-string
         ((lambda ()
            (1-
             (setq
              rope-read-olimid-next-unused
              (1+ rope-read-olimid-next-unused)))))))))))
;; #+END_SRC

;; ** Provide the file as library

;; #+BEGIN_SRC emacs-lisp
(provide 'rope-read-mode)
;; #+END_SRC

;;; Tail:

;; # Local Variables:
;; # lentic-init: lentic-orgel-org-init
;; # End:

;;; rope-read-mode.el ends here
