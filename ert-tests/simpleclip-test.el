
;;; requires and setup

(when load-file-name
  (setq package-enable-at-startup nil)
  (setq package-load-list nil)
  (when (fboundp 'package-initialize)
    (package-initialize)))

(require 'simpleclip)


;;; simpleclip-mode

(ert-deftest simpleclip-mode-01 nil
  (let ((kept simpleclip-mode))
    (simpleclip-mode 1)
    (should simpleclip-mode)
    (simpleclip-mode -1)
    (should-not simpleclip-mode)
    (when kept
      (simpleclip-mode 1))))


;;; simpleclip-set-contents / simpleclip-get-contents

(ert-deftest simpleclip-set-contents-01 nil
  :tags '(:interactive)
  (let ((kept (simpleclip-get-contents))
        (value "__PASTEBOARD_TEST__"))
    (should-not
     (equal value
            (simpleclip-get-contents)))
    (simpleclip-set-contents value)
    (should
     (equal value
            (simpleclip-get-contents)))
    (should
     (equal value
            (simpleclip-get-contents)))
    (simpleclip-set-contents kept)))

(ert-deftest simpleclip-set-contents-02 nil
  :tags '(:interactive)
  (let ((kept (simpleclip-get-contents))
        (value nil))
    (simpleclip-set-contents value)
    (should
     (equal ""
            (simpleclip-get-contents)))
    (should
     (equal ""
            (simpleclip-get-contents)))
    (simpleclip-set-contents kept)))

(ert-deftest simpleclip-set-contents-03 nil
  :tags '(:interactive)
  (let ((kept (simpleclip-get-contents))
        (value "__PASTEBOARD_TEST__"))
    (should-not
     (equal value
            (simpleclip-get-contents)))
    (simpleclip-set-contents value)
    (should
     (equal value
            (simpleclip-get-contents)))
    (should-not
     (equal value
            (car kill-ring)))
    (simpleclip-set-contents kept)))


;;; simpleclip-copy

(ert-deftest simpleclip-copy-01 nil
  :tags '(:interactive)
  (let ((kept (simpleclip-get-contents))
        (value "__PASTEBOARD_TEST__"))
    (with-temp-buffer
      (insert value)
      (should-not
       (equal value
              (simpleclip-get-contents)))
      (goto-char (point-min))
      (push-mark (point-max) t t)
      (call-interactively 'simpleclip-copy)
      (should
       (equal value
              (simpleclip-get-contents)))
      (should-not
       (equal value
              (car kill-ring)))
      (should
       (equal value
              (buffer-string)))
      (simpleclip-set-contents kept))))


;;; simpleclip-cut

(ert-deftest simpleclip-cut-01 nil
  :tags '(:interactive)
  (let ((kept (simpleclip-get-contents))
        (value "__PASTEBOARD_TEST__"))
    (with-temp-buffer
      (insert value)
      (should-not
       (equal value
              (simpleclip-get-contents)))
      (goto-char (point-min))
      (push-mark (point-max) t t)
      (call-interactively 'simpleclip-cut)
      (should
       (equal value
              (simpleclip-get-contents)))
      (should-not
       (equal value
              (car kill-ring)))
      (should
       (= (length (buffer-string)) 0))
      (simpleclip-set-contents kept))))


;;; simpleclip-paste

(ert-deftest simpleclip-paste-01 nil
  :tags '(:interactive)
  (let ((kept (simpleclip-get-contents))
        (value "__PASTEBOARD_TEST__"))
    (with-temp-buffer
      (should-not
       (equal value
              (simpleclip-get-contents)))
      (simpleclip-set-contents value)
      (simpleclip-paste)
      (should-not
       (equal value
              (car kill-ring)))
      (should
       (equal value
              (buffer-string)))
      (simpleclip-set-contents kept))))


;;
;; Emacs
;;
;; Local Variables:
;; indent-tabs-mode: nil
;; mangle-whitespace: t
;; require-final-newline: t
;; coding: utf-8
;; byte-compile-warnings: (not cl-functions)
;; End:
;;

;;; simpleclip-test.el ends here
