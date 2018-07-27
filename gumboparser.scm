(library (gumboparser)
         (export
           GumboSourcePosition
           GumboStringPiece
           GumboVector
           GumboTag
           GumboAttributeNamespace
           GumboNodeType
           GumboQuirksMode
           GumboNamespaceEnum
           GUMBO_INSERTION_NORMAL
           GUMBO_INSERTION_BY_PARSER
           GUMBO_INSERTION_IMPLICIT_END_TAG
           GUMBO_INSERTION_IMPLIED
           GUMBO_INSERTION_CONVERTED_FROM_END_TAG
           GUMBO_INSERTION_FROM_ISINDEX
           GUMBO_INSERTION_FROM_IMAGE
           GUMBO_INSERTION_RECONSTRUCTED_FORMATTING_ELEMENT
           GUMBO_INSERTION_ADOPTION_AGENCY_CLONED
           GUMBO_INSERTION_ADOPTION_AGENCY_MOVED
           GUMBO_INSERTION_FOSTER_PARENTED
           )
         (import (chezscheme))
         (define-ftype GumboSourcePosition
                       (struct
                         (line unsigned)
                         (column unsigned)
                         (offset unsigned)))
         (define-ftype GumboStringPiece
                       (struct
                         (data (* char))
                         (length size_t)))
         (define-ftype GumboVector
                       (struct
                         (data (* void*))
                         (length unsigned)
                         (capacity unsigned)))
         (define-ftype GumboStringEqaulTy
                       (function ((* GumboStringPiece) (* GumboStringPiece)) boolean))
         (define-ftype GumboVectorIndexOfTy
                       (function ((* GumboVector) void*) int))
         (define-ftype GumboNormalizedTagnameTy (function (int) (* char)))
         (define-ftype GumboTagFromOriginalTextTy (function ((* GumboStringPiece)) void))
         (define-ftype GumboNormalizeSvgTagnameTy (function ((* GumboStringPiece)) (* char)))
         (define-ftype GumboTagEnumTy (function ((* char)) int))
         (define-ftype GumboTagNEnumTy (function ((* char) unsigned) int))
         (define-ftype GumboAttribute
                       (struct
                         (attr_namespace int)
                         (name (* char))
                         (original_name GumboStringPiece)
                         (value (* char))
                         (original_value GumboStringPiece)
                         (name_start GumboSourcePosition)
                         (name_end GumboSourcePosition)
                         (value_start GumboSourcePosition)
                         (value_end GumboSourcePosition)))
         (define-ftype GumboGetAttributeTy (function ((* GumboVector) (* char)) (* GumboAttribute)))
         (define-ftype GumboDocument
                       (struct
                         (children GumboVector)
                         (has_doctype boolean)
                         (name (* char))
                         (public_identifier (* char))
                         (system_identifier (* char))
                         (doc_type_quirks_mode int)))
         (define-ftype GumboText
                       (struct
                         (text (* char))
                         (original_text GumboStringPiece)
                         (start_pos GumboSourcePosition)))
         (define-ftype GumboElement
                       (struct
                         (children GumboVector)
                         (tag int)
                         (tag_namespace int)
                         (original_tag GumboStringPiece)
                         (original_end_tag GumboStringPiece)
                         (start_pos GumboSourcePosition)
                         (end_pos GumboSourcePosition)
                         (attributes GumboVector)))
         (define-ftype GumboNode
                       (struct
                         (type int)
                         (parent (* GumboNode))
                         (index_within_parent size_t)
                         (parse_flags int)
                         (v (union 
                                 (document GumboDocument)
                                 (element GumboElement)
                                 (text GumboText)))))
         (define-ftype GumboAllocatorFunction
                       (* (function (void* size_t) void*)))
         (define-ftype GumboDeallocatorFunction
                       (* (function (void* void*) void)))
         (define-ftype GumboOptions
                       (struct
                         (allocator GumboAllocatorFunction)
                         (deallocator GumboDeallocatorFunction)
                         (userdata void*)
                         (tab_stop int)
                         (stop_on_first_error boolean)
                         (max_error int)
                         (fragment_context int)
                         (fragment_namespace int)))
         (define-ftype GumboOutput
                       (struct
                         (document (* GumboNode))
                         (root (* GumboNode))
                         (errors GumboVector)))
         (define-ftype GumboParseTy (function ((* char)) (* GumboOutput)))
         (define-ftype GumboParseWithOptionsTy (function ((* GumboOptions) (* char) size_t) (* GumboOutput)))
         (define-ftype GumboDestroyOutputTy (function ((* GumboOptions) (* GumboOutput)) void))
         (define LoadSharedLibrary)
         (define GumboTag
           (make-enumeration
             '(
              GUMBO_TAG_HTML
              GUMBO_TAG_HEAD
              GUMBO_TAG_TITLE
              GUMBO_TAG_BASE
              GUMBO_TAG_LINK
              GUMBO_TAG_META
              GUMBO_TAG_STYLE
              GUMBO_TAG_SCRIPT
              GUMBO_TAG_NOSCRIPT
              GUMBO_TAG_TEMPLATE
              GUMBO_TAG_BODY
              GUMBO_TAG_ARTICLE
              GUMBO_TAG_SECTION
              GUMBO_TAG_NAV
              GUMBO_TAG_ASIDE
              GUMBO_TAG_H1
              GUMBO_TAG_H2
              GUMBO_TAG_H3
              GUMBO_TAG_H4
              GUMBO_TAG_H5
              GUMBO_TAG_H6
              GUMBO_TAG_HGROUP
              GUMBO_TAG_HEADER
              GUMBO_TAG_FOOTER
              GUMBO_TAG_ADDRESS
              GUMBO_TAG_P
              GUMBO_TAG_HR
              GUMBO_TAG_PRE
              GUMBO_TAG_BLOCKQUOTE
              GUMBO_TAG_OL
              GUMBO_TAG_UL
              GUMBO_TAG_LI
              GUMBO_TAG_DL
              GUMBO_TAG_DT
              GUMBO_TAG_DD
              GUMBO_TAG_FIGURE
              GUMBO_TAG_FIGCAPTION
              GUMBO_TAG_MAIN
              GUMBO_TAG_DIV
              GUMBO_TAG_A
              GUMBO_TAG_EM
              GUMBO_TAG_STRONG
              GUMBO_TAG_SMALL
              GUMBO_TAG_S
              GUMBO_TAG_CITE
              GUMBO_TAG_Q
              GUMBO_TAG_DFN
              GUMBO_TAG_ABBR
              GUMBO_TAG_DATA
              GUMBO_TAG_TIME
              GUMBO_TAG_CODE
              GUMBO_TAG_VAR
              GUMBO_TAG_SAMP
              GUMBO_TAG_KBD
              GUMBO_TAG_SUB
              GUMBO_TAG_SUP
              GUMBO_TAG_I
              GUMBO_TAG_B
              GUMBO_TAG_U
              GUMBO_TAG_MARK
              GUMBO_TAG_RUBY
              GUMBO_TAG_RT
              GUMBO_TAG_RP
              GUMBO_TAG_BDI
              GUMBO_TAG_BDO
              GUMBO_TAG_SPAN
              GUMBO_TAG_BR
              GUMBO_TAG_WBR
              GUMBO_TAG_INS
              GUMBO_TAG_DEL
              GUMBO_TAG_IMAGE
              GUMBO_TAG_IMG
              GUMBO_TAG_IFRAME
              GUMBO_TAG_EMBED
              GUMBO_TAG_OBJECT
              GUMBO_TAG_PARAM
              GUMBO_TAG_VIDEO
              GUMBO_TAG_AUDIO
              GUMBO_TAG_SOURCE
              GUMBO_TAG_TRACK
              GUMBO_TAG_CANVAS
              GUMBO_TAG_MAP
              GUMBO_TAG_AREA
              GUMBO_TAG_MATH
              GUMBO_TAG_MI
              GUMBO_TAG_MO
              GUMBO_TAG_MN
              GUMBO_TAG_MS
              GUMBO_TAG_MTEXT
              GUMBO_TAG_MGLYPH
              GUMBO_TAG_MALIGNMARK
              GUMBO_TAG_ANNOTATION_XML
              GUMBO_TAG_SVG
              GUMBO_TAG_FOREIGNOBJECT
              GUMBO_TAG_DESC
              GUMBO_TAG_TABLE
              GUMBO_TAG_CAPTION
              GUMBO_TAG_COLGROUP
              GUMBO_TAG_COL
              GUMBO_TAG_TBODY
              GUMBO_TAG_THEAD
              GUMBO_TAG_TFOOT
              GUMBO_TAG_TR
              GUMBO_TAG_TD
              GUMBO_TAG_TH
              GUMBO_TAG_FORM
              GUMBO_TAG_FIELDSET
              GUMBO_TAG_LEGEND
              GUMBO_TAG_LABEL
              GUMBO_TAG_INPUT
              GUMBO_TAG_BUTTON
              GUMBO_TAG_SELECT
              GUMBO_TAG_DATALIST
              GUMBO_TAG_OPTGROUP
              GUMBO_TAG_OPTION
              GUMBO_TAG_TEXTAREA
              GUMBO_TAG_KEYGEN
              GUMBO_TAG_OUTPUT
              GUMBO_TAG_PROGRESS
              GUMBO_TAG_METER
              GUMBO_TAG_DETAILS
              GUMBO_TAG_SUMMARY
              GUMBO_TAG_MENU
              GUMBO_TAG_MENUITEM
              GUMBO_TAG_APPLET
              GUMBO_TAG_ACRONYM
              GUMBO_TAG_BGSOUND
              GUMBO_TAG_DIR
              GUMBO_TAG_FRAME
              GUMBO_TAG_FRAMESET
              GUMBO_TAG_NOFRAMES
              GUMBO_TAG_ISINDEX
              GUMBO_TAG_LISTING
              GUMBO_TAG_XMP
              GUMBO_TAG_NEXTID
              GUMBO_TAG_NOEMBED
              GUMBO_TAG_PLAINTEXT
              GUMBO_TAG_RB
              GUMBO_TAG_STRIKE
              GUMBO_TAG_BASEFONT
              GUMBO_TAG_BIG
              GUMBO_TAG_BLINK
              GUMBO_TAG_CENTER
              GUMBO_TAG_FONT
              GUMBO_TAG_MARQUEE
              GUMBO_TAG_MULTICOL
              GUMBO_TAG_NOBR
              GUMBO_TAG_SPACER
              GUMBO_TAG_TT
              GUMBO_TAG_RTC
              GUMBO_TAG_UNKNOWN
              GUMBO_TAG_LAST
             )))
         (define GumboAttributeNamespace
           (make-enumeration
             '(
               GUMBO_ATTR_NAMESPACE_NONE
               GUMBO_ATTR_NAMESPACE_XLINK
               GUMBO_ATTR_NAMESPACE_XML
               GUMBO_ATTR_NAMESPACE_XMLNS
              )))
         (define GumboNodeType
           (make-enumeration
             '(
               GUMBO_NODE_DOCUMENT
               GUMBO_NODE_ELEMENT
               GUMBO_NODE_TEXT
               GUMBO_NODE_CDATA
               GUMBO_NODE_COMMENT
               GUMBO_NODE_WHITESPACE
               GUMBO_NODE_TEMPLATE
               )))
         (define GumboQuirksMode
           (make-enumeration
             '(
               GUMBO_DOCTYPE_NO_QUIRKS
               GUMBO_DOCTYPE_QUIRKS
               GUMBO_DOCTYPE_LIMITED_QUIRKS
               )))
         (define GumboNamespaceEnum
           (make-enumeration
             '(
               GUMBO_NAMESPACE_HTML
               GUMBO_NAMESPACE_SVG
               GUMBO_NAMESPACE_MATHML
               )))
         (define GUMBO_INSERTION_NORMAL 0)
         (define GUMBO_INSERTION_BY_PARSER (bitwise-arithmetic-shift-left 1 0))
         (define GUMBO_INSERTION_IMPLICIT_END_TAG (bitwise-arithmetic-shift-left 1 1))
         (define GUMBO_INSERTION_IMPLIED (bitwise-arithmetic-shift-left 1 3))
         (define GUMBO_INSERTION_CONVERTED_FROM_END_TAG (bitwise-arithmetic-shift-left 1 4))
         (define GUMBO_INSERTION_FROM_ISINDEX (bitwise-arithmetic-shift-left 1 5))
         (define GUMBO_INSERTION_FROM_IMAGE (bitwise-arithmetic-shift-left 1 6))
         (define GUMBO_INSERTION_RECONSTRUCTED_FORMATTING_ELEMENT (bitwise-arithmetic-shift-left 1 7))
         (define GUMBO_INSERTION_ADOPTION_AGENCY_CLONED (bitwise-arithmetic-shift-left 1 8))
         (define GUMBO_INSERTION_ADOPTION_AGENCY_MOVED (bitwise-arithmetic-shift-left 1 9))
         (define GUMBO_INSERTION_FOSTER_PARENTED (bitwise-arithmetic-shift-left 1 10))
         (define GumboStringEqaul)
         (define GumboStringEqaulIgnoreCase)
         (define GumboVectorIndexOf)
         (define GumboNormalizedTagname)
         (define GumboTagFromOriginalText)
         (define GumboNormalizeSvgTagname)
         (define GumboTagEnum)
         (define GumboTagNEnum)
         (define GumboGetAttribute)
         (define GumboParse)
         (define GumboParseWithOptions)
         (define GumboDestroyOutput)
         (load-shared-object "libgumbo.so")
         (set! GumboStringEqaul (make-ftype-pointer GumboStringEqaulTy (foreign-entry "gumbo_string_equals")))
         (set! GumboStringEqaulIgnoreCase (make-ftype-pointer GumboStringEqaulTy (foreign-entry "gumbo_string_equals_ignore_case")))
         (set! GumboVectorIndexOf (make-ftype-pointer GumboVectorIndexOfTy (foreign-entry "gumbo_vector_index_of")))
         (set! GumboNormalizedTagname (make-ftype-pointer GumboNormalizedTagnameTy (foreign-entry "gumbo_normalized_tagname")))
         (set! GumboTagFromOriginalText (make-ftype-pointer GumboTagFromOriginalTextTy (foreign-entry "gumbo_tag_from_original_text")))
         (set! GumboNormalizeSvgTagname (make-ftype-pointer GumboNormalizeSvgTagnameTy (foreign-entry "gumbo_normalize_svg_tagname")))
         (set! GumboTagEnum (make-ftype-pointer GumboTagEnumTy (foreign-entry "gumbo_tag_enum")))
         (set! GumboTagNEnum (make-ftype-pointer GumboTagNEnumTy (foreign-entry "gumbo_tagn_enum")))
         (set! GumboGetAttribute (make-ftype-pointer GumboGetAttributeTy (foreign-entry "gumbo_get_attribute")))
         (set! GumboParse (make-ftype-pointer GumboParseTy (foreign-entry "gumbo_parse")))
         (set! GumboParseWithOptions (make-ftype-pointer GumboParseWithOptionsTy (foreign-entry "gumbo_parse_with_options")))
         (set! GumboDestroyOutput (make-ftype-pointer GumboDestroyOutputTy (foreign-entry "gumbo_destroy_output")))
)
