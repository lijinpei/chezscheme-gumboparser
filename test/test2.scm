(load-shared-object "libgumbo.so")
(import (gumboparser) (cgumboparser))
(define transcoder (make-transcoder (utf-8-codec)))
(define bv (get-string-all (open-file-input-port "/home/lijinpei/tmp/index.html" (file-options no-create) (buffer-mode block) transcoder)))
(define p (GumboParse bv))
(define doc_node (GumboOutput-Document p))
(define root_node (GumboOutput-Root p))
(define errors (GumboOutput-Errors p))
(display (GumboVector-Length errors))
(newline)
(define root_node_type (GumboNode-Type root_node))
(display root_node_type)
(newline)
(define doc_node_type (GumboNode-Type doc_node))
(display doc_node_type)
(define root_v (GumboNode-V root_node))
(define doc_v (GumboNode-V doc_node))
(newline)
(display doc_v)
(newline)
(define doc_name (bytevector->string (GumboDocument-Name doc_v) transcoder))
(display doc_name)
(newline)
(define doc_public_identifier (bytevector->string (GumboDocument-PublicIdentifier doc_v) transcoder))
(display doc_public_identifier)
(newline)
(define doc_system_identifier (bytevector->string (GumboDocument-SystemIdentifier doc_v) transcoder))
(display doc_public_identifier)
(newline)
(define doc_children (GumboDocument-Children doc_v))
(define doc_children_number (GumboVector-Length doc_children))
(display doc_children_number)
(newline)
(define doc_children0_ (GumboVector-Index doc_children 0))
(define doc_children0 (GumboVector-IndexAs doc_children 0 CGumboNode))
(define doc_children0_type (GumboNode-Type doc_children0))
(display doc_children0_type)
(newline)
(define doc_children0_v (GumboNode-V doc_children0))
(display doc_children0_v)
(newline)
(define doc_children0_tag (GumboElement-Tag doc_children0_v))
(display doc_children0_tag)
(newline)
(display (GumboNormalizedTagname doc_children0_tag))
(newline)
(define doc_children0_children (GumboElement-Children doc_children0_v))
(define doc_children0_children_num (GumboVector-Length doc_children0_children))
(display doc_children0_children_num)
(newline)
(GumboDestroyOutput GumboDefaultOptions p)

