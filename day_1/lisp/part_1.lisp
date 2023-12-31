(let ((numchar1 (list #\0 #\1 #\2 #\3 #\4 #\5 #\6 #\7 #\8 #\9)) (numnum1 (list 0 1 2 3 4 5 6 7 8 9)) (total 0))
  (let ((numchar (let ((temp nil)) (dotimes (i 100 (nreverse temp)) (push (concatenate 'string (string (nth (floor (/ i 10)) numchar1)) (string (nth (mod i 10) numchar1))) temp))))
        (numnum (let ((temp nil)) (dotimes (i 100 (nreverse temp)) (push i temp)))))
    (flet ((nmap (x) (nth (position-if #'(lambda (a) (equal x a)) numchar) numnum)))
      (with-open-file (in "../input_1")
                      (do ((line (read-line in nil "end") (read-line in nil "end")))
                          ((equal line "end"))
                        (let ((nums (do ((pos 0 (+ pos 1)) (nums nil))
                                        ((> pos (length line)) nums)
                                      (when (find (nth pos (concatenate 'list line)) numchar1) (setq nums (append nums (list (nth pos (concatenate 'list line)))))))))
                          (setq nums (nmap (concatenate 'string (list (nth 0 nums) (nth (- (length nums) 1) nums)))))
                          (setq total (+ total nums)))
                        (format t "~s~%" total))))))
