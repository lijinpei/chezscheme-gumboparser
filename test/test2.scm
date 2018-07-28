(load-shared-object "libgumbo.so")
(import (gumboparser))
(define bv (get-string-all (open-file-input-port "/home/lijinpei/tmp/index.html" (file-options no-create) (buffer-mode block) (make-transcoder (utf-8-codec)))))
(define p (GumboParse bv))
(GumboDestroyOutput GumboDefaultOptions p)

