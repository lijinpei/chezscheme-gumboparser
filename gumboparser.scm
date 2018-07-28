(library (gumboparser)
         (export
           pu8-strlen
           pu8-to-scheme-bytevector
           reinterpret_cast

           GumboSourcePosition
           GumboStringPiece
           GumboVector
           GumboStringEquals
           GumboStringEqualsIgnoreCase

           GumboSourcePosition-Line
           GumboSourcePosition-Column
           GumboSourcePosition-Offset

           GumboStringPiece-Data
           GumboStringPiece-Length

           GumboVector-Data
           GumboVector-Length
           GumboVector-Capacity
           GumboVector-Index
           GumboVector-IndexAs

           GumboAttribute-AttrNamespace
           GumboAttribute-Name
           GumboAttribute-OriginalName
           GumboAttribute-Value
           GumboAttribute-OriginalValue
           GumboAttribute-NameStart
           GumboAttribute-NameEnd
           GumboAttribute-ValueStart
           GumboAttribute-ValueEnd

           GumboDocument-Children
           GumboDocument-HasDocType
           GumboDocument-Name
           GumboDocument-PublicIdentifier
           GumboDocument-SystemIdentifier
           GumboDocument-DocTypeQuirksMode

           GumboText-Text
           GumboText-OriginalText
           GumboText-StartPos

           GumboElement-Children
           GumboElement-Tag
           GumboElement-TagNamespace
           GumboElement-OriginalEndTag
           GumboElement-StartPos
           GumboElement-EndPos
           GumboElement-Attributes

           GumboNode-Type
           GumboNode-Parent
           GumboNode-IndexWithinParent
           GumboNode-ParseFlags
           GumboNode-V

           GumboOptions-Allocator
           GumboOptions-Deallocator
           GumboOptions-Userdata
           GumboOptions-TabStop
           GumboOptions-StopOnFirstError
           GumboOptions-MaxErrors
           GumboOptions-FragmentContext
           GumboOptions-FragmentNamespace

           GumboOutput-Document
           GumboOutput-Root
           GumboOutput-Errors

           GumboParse
           GumboNormalizedTagname
           GumboDestroyOutput
           GumboEmptySourcePosition
           GumboEmptyString
           GumboEmptyVector
           GumboDefaultOptions
           )
         (import (chezscheme) (cgumboparser))
         ;;; helpers
         (define (pu8-strlen p)
           (let for ((i 0))
             (if (equal? 0 (ftype-ref unsigned-8 () p i)) i (for (+ i 1)))))
         (define pu8-to-scheme-bytevector
           (case-lambda
             ((p) (pu8-to-scheme-bytevector p (pu8-strlen p)))
             ((p l)
           (let ((ret (make-bytevector l)))
             (let for ((i 0))
               (if (< i l) (begin (bytevector-u8-set! ret i (ftype-ref unsigned-8 () p i)) (for (+ i 1))))) ret))))
         (define-syntax reinterpret_cast (syntax-rules () ((_ p t) (make-ftype-pointer t p))))
;         (define-syntax reinterpret_cast (syntax-rules () ((_ p t) (begin (display (ftype-pointer-address p) (make-ftype-pointer t p))))))
         ;;; constructors
         (define GumboSourcePosition #f)
         (define GumboStringPiece #f)
         (define GumboVector #f)
         (define GumboStringEquals #f)
         (define GumboStringEqualsIgnoreCase #f)
         (define GumboVectorIndexOf #f)

         ;;; accessors
         (define (GumboSourcePosition-Line p)
           (assert (ftype-pointer? CGumboSourcePosition p))
           (ftype-ref CGumboSourcePosition (line) p))
         (define (GumboSourcePosition-Column p)
           (assert (ftype-pointer? CGumboSourcePosition p))
           (ftype-ref CGumboSourcePosition (column) p))
         (define (GumboSourcePosition-Offset p)
           (assert (ftype-pointer? CGumboSourcePosition p))
           (ftype-ref CGumboSourcePosition (offset) p))

         (define (GumboStringPiece-Data p)
           (assert (ftype-pointer? CGumboStringPiece p))
           (pu8-to-scheme-bytevector (ftype-ref CGumboStringPiece (data) p) (GumboStringPiece-Length p)))
         (define (GumboStringPiece-Length p)
           (assert (ftype-pointer? CGumboStringPiece p))
           (ftype-ref CGumboStringPiece (length) p))

         (define (GumboVector-Data p)
           (assert (ftype-pointer? CGumboVector p))
           (ftype-ref CGumboVector (data) p))
         (define (GumboVector-Length p)
           (assert (ftype-pointer? CGumboVector p))
           (ftype-ref CGumboVector (length) p))
         (define (GumboVector-Capacity p)
           (assert (ftype-pointer? CGumboVector p))
           (ftype-ref CGumboVector (capacity) p))
         (define (GumboVector-Index p i)
           (assert (ftype-pointer? CGumboVector p))
           (ftype-ref CGumboVector (data i) p))
         (define-syntax GumboVector-IndexAs
           (syntax-rules ()
              ((_ p i t) (reinterpret_cast (GumboVector-Index p i) t))))

         (define (GumboAttribute-AttrNamespace p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-ref CGumboAttribute (attr_namespace) p))
         (define (GumboAttribute-Name p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-ref CGumboAttribute (name) p))
         (define (GumboAttribute-OriginalName p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-&ref CGumboAttribute (original_name) p))
         (define (GumboAttribute-Value p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-ref CGumboAttribute (value) p))
         (define (GumboAttribute-OriginalValue p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-&ref CGumboAttribute (original_value) p))
         (define (GumboAttribute-NameStart p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-&ref CGumboAttribute (name_start) p))
         (define (GumboAttribute-NameEnd p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-&ref CGumboAttribute (name_end) p))
         (define (GumboAttribute-ValueStart p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-&ref CGumboAttribute (value_start) p))
         (define (GumboAttribute-ValueEnd p)
           (assert (ftype-pointer? CGumboAttribute p))
           (ftype-&ref CGumboAttribute (value_end) p))

         (define (GumboDocument-Children p)
           (assert (ftype-pointer? CGumboDocument p))
           (ftype-&ref CGumboDocument (children) p))
         (define (GumboDocument-HasDocType p)
           (assert (ftype-pointer? CGumboDocument p))
           (ftype-ref CGumboDocument (has_doctype) p))
         (define (GumboDocument-Name p)
           (assert (ftype-pointer? CGumboDocument p))
           (pu8-to-scheme-bytevector (ftype-ref CGumboDocument (name) p)))
         (define (GumboDocument-PublicIdentifier p)
           (assert (ftype-pointer? CGumboDocument p))
           (pu8-to-scheme-bytevector (ftype-ref CGumboDocument (public_identifier) p)))
         (define (GumboDocument-SystemIdentifier p)
           (assert (ftype-pointer? CGumboDocument p))
           (pu8-to-scheme-bytevector (ftype-ref CGumboDocument (system_identifier) p)))
         (define (GumboDocument-DocTypeQuirksMode p)
           (assert (ftype-pointer? CGumboDocument p))
           (ftype-ref CGumboDocument (doc_type_quirks_mode) p))

         (define (GumboText-Text p)
           (assert (ftype-pointer? CGumboText p))
           (ftype-ref CGumboText (text) p))
         (define (GumboText-OriginalText p)
           (assert (ftype-pointer? CGumboText p))
           (ftype-&ref CGumboText (original_text) p))
         (define (GumboText-StartPos p)
           (assert (ftype-pointer? CGumboText p))
           (ftype-&ref CGumboText (start_pos) p))

         (define (GumboElement-Children p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-&ref CGumboElement (children) p))
         (define (GumboElement-Tag p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-ref CGumboElement (tag) p))
         (define (GumboElement-TagNamespace p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-ref CGumboElement (tag_namespace) p))
         (define (GumboElement-OriginalEndTag p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-&ref CGumboElement (original_tag) p))
         (define (GumboElement-StartPos p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-&ref CGumboElement (start_pos) p))
         (define (GumboElement-EndPos p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-&ref CGumboElement (end_pos) p))
         (define (GumboElement-Attributes p)
           (assert (ftype-pointer? CGumboElement p))
           (ftype-&ref CGumboElement (attributes) p))

         (define (GumboNode-Type p)
           (assert (ftype-pointer? CGumboNode p))
           (ftype-ref CGumboNode (type) p))
         (define (GumboNode-Parent p)
           (assert (ftype-pointer? CGumboNode p))
           (ftype-ref CGumboNode (parent) p))
         (define (GumboNode-IndexWithinParent p)
           (assert (ftype-pointer? CGumboNode p))
           (ftype-ref CGumboNode (index_within_parent) p))
         (define (GumboNode-ParseFlags p)
           (assert (ftype-pointer? CGumboNode p))
           (ftype-ref CGumboNode (parse_flags) p))
         (define (GumboNode-V p)
           (assert (ftype-pointer? CGumboNode p))
           (let ((type (GumboNode-Type p)))
             (cond
             ((equal? type (CGumboNodeType-indexer 'GUMBO_NODE_DOCUMENT)) (ftype-&ref CGumboNode (v document) p))
             ((equal? type (CGumboNodeType-indexer 'GUMBO_NODE_ELEMENT)) (ftype-&ref CGumboNode (v element) p))
             ((<= type (CGumboNodeType-indexer 'GUMBO_NODE_TEMPLATE )) (ftype-&ref CGumboNode (v text) p))
             (else #f))))

         (define (GumboOptions-Allocator p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (allocator) p))
         (define (GumboOptions-Deallocator p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (deallocator) p))
         (define (GumboOptions-Userdata p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (userdata) p))
         (define (GumboOptions-TabStop p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (tab_stop) p))
         (define (GumboOptions-StopOnFirstError p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (stop_on_first_error) p))
         (define (GumboOptions-MaxErrors p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (max_errors) p))
         (define (GumboOptions-FragmentContext p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (fragment_context) p))
         (define (GumboOptions-FragmentNamespace p)
           (assert (ftype-pointer? CGumboOptions p))
           (ftype-ref CGumboOptions (fragment_namespace) p))

         (define (GumboOutput-Document p)
           (assert (ftype-pointer? CGumboOutput p))
           (ftype-ref CGumboOutput (document) p))
         (define (GumboOutput-Root p)
           (assert (ftype-pointer? CGumboOutput p))
           (ftype-ref CGumboOutput (root) p))
         (define (GumboOutput-Errors p)
           (assert (ftype-pointer? CGumboOutput p))
           (ftype-&ref CGumboOutput (errors) p))

         ;;; functions
         (define GumboParse (foreign-procedure #f (foreign-entry "gumbo_parse") (utf-8) (* CGumboOutput)))
         (define GumboNormalizedTagname (foreign-procedure #f (foreign-entry "gumbo_normalized_tagname") (int) utf-8))
         (define GumboDestroyOutput CGumboDestroyOutput)
         (define GumboEmptySourcePosition CGumboEmptySourcePosition)
         (define GumboEmptyString CGumboEmptyString)
         (define GumboEmptyVector CGumboEmptyVector)
         (define GumboDefaultOptions CGumboDefaultOptions)
)
