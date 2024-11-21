Class {
	#name : 'WolframExpression',
	#superclass : 'Object',
	#instVars : [
		'head',
		'arguments',
		'link',
		'showPdfInsteadOfTeX'
	],
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'visiting' }
WolframExpression >> ! exp [

	^ (self valueWithArguments: { exp }) value
]

{ #category : 'visiting' }
WolframExpression >> & recvBlock [

	| f |
	f := link head: 'Function' arguments: { self }.

	^ recvBlock value: f
]

{ #category : 'visiting' }
WolframExpression >> && exp [

	^ (link head: 'And' arguments: {
			   self.
			   exp }) simplify
]

{ #category : 'visiting' }
WolframExpression >> * exp [

	^ (link head: 'Times' arguments: {
			   self.
			   exp }) simplify
]

{ #category : 'visiting' }
WolframExpression >> ** exp [

	^ (link head: 'Power' arguments: {
			   self.
			   exp }) simplify
]

{ #category : 'visiting' }
WolframExpression >> + exp [

	^ (link head: 'Plus' arguments: {
			   self.
			   exp }) simplify
]

{ #category : 'visiting' }
WolframExpression >> - exp [

	^ (link head: 'Subtract' arguments: {
			   self.
			   exp }) simplify
]

{ #category : 'visiting' }
WolframExpression >> / exp [

	^ (link head: 'Divide' arguments: {
			   self.
			   exp }) simplify
]

{ #category : 'visiting' }
WolframExpression >> /, exp [

	^ link head: 'ReplaceAll' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> //, exp [

	^ link head: 'ReplaceRepeated' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> /@ exp [

	^ link head: 'Map' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> <- exp [

	^ link head: 'Set' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> <-| exp [

	^ exp |-> self
]

{ #category : 'comparing' }
WolframExpression >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject ifTrue: [ ^ true ].
	self class = anObject class ifFalse: [ ^ false ].
	^ head = anObject head and: [ arguments = anObject arguments ]
]

{ #category : 'visiting' }
WolframExpression >> === exp [

	^ link head: 'Equal' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> => exp [

	^ link head: 'Implies' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> > exp [

	^ link head: 'Greater' arguments: {
			  self.
			  exp }
]

{ #category : 'evaluating' }
WolframExpression >> ? args [

	^ link head: 'Information' arguments: { self } , args
]

{ #category : 'visiting' }
WolframExpression >> @ exp [

	^ link head: 'Indexed' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> @! exp [

	^ link head: 'Part' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> @* exp [

	^ link head: 'Composition' arguments: {
			  self.
			  exp }
]

{ #category : 'visiting' }
WolframExpression >> @@ args [

	^ link head: 'Apply' arguments: {
			  self.
			  args }
]

{ #category : 'accessing' }
WolframExpression >> _ [

	^ self pattern: link _
]

{ #category : 'visiting' }
WolframExpression >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitWolframExpression: self
]

{ #category : 'arithmetic' }
WolframExpression >> adaptToNumber: recv andSend: selector [

	^ (recv asWolframExpression: link) perform: selector with: self
]

{ #category : 'accessing' }
WolframExpression >> arguments [

	^ arguments
]

{ #category : 'accessing' }
WolframExpression >> arguments: anObject [

	arguments := anObject
]

{ #category : 'evaluating' }
WolframExpression >> asDefaultShapeForWalker: walker descriptor: descriptor [

	^ showPdfInsteadOfTeX
		  ifTrue: [ self asExportedPdfShape ]
		  ifFalse: [ self asTeXifiedShape ]
]

{ #category : 'evaluating' }
WolframExpression >> asExportedPdfShape [

	| fileReference fullName shape |
	fileReference := FileReference
		                 newTempFilePrefix: 'wolfram-'
		                 suffix: ''.

	fullName := fileReference fullName , '.pdf'.

	(link head: 'Export' arguments: {
			 fullName.
			 (link head: 'Style' arguments: {
					  self.
					  (#FontFamily -> 'Source Sans Pro') }).
			 "self."
			 'PDF' }) value.

	shape := fullName asFileReference asPdf pages
		         ifEmpty: [ RSComposite new ]
		         ifNotEmpty: [ :pages | pages first ].

	^ shape
		  model: self;
		  yourself
]

{ #category : 'string' }
WolframExpression >> asMathematicaPrintString [

	^ self holdForm textString
]

{ #category : 'evaluating' }
WolframExpression >> asTeXifiedShape [

	| texContent texChunk shape |
	texChunk := self holdForm texForm toString
		            copyReplaceAll: '\text'
		            with: ''.

	texContent := self withStandaloneLaTeXStreamDo: [ :aStream |
		              aStream << texChunk ].

	shape := (PopplerPdf compileTeX: texContent times: 1) pages
		         ifEmpty: [ RSComposite new ]
		         ifNotEmpty: [ :pages | pages first ].

	^ shape
		  model: self;
		  yourself
]

{ #category : 'manipulation' }
WolframExpression >> binomial: k [

	^ link head: 'Binomial' arguments: {
			  self.
			  k }
]

{ #category : 'manipulation' }
WolframExpression >> binomialDistribution: p [

	^ link head: 'BinomialDistribution' arguments: {
			  self.
			  p }
]

{ #category : 'evaluating' }
WolframExpression >> evaluate [

	^ self -> self value
]

{ #category : 'arithmetic' }
WolframExpression >> factor [

	^ (link head: 'Factor' arguments: { self }) value
]

{ #category : 'arithmetic' }
WolframExpression >> factorInteger [

	^ (link head: 'FactorInteger' arguments: { self }) value
]

{ #category : 'arithmetic' }
WolframExpression >> fullSimplify [

	^ (link head: 'FullSimplify' arguments: { self }) value
]

{ #category : 'manipulation' }
WolframExpression >> functionExpand [

	^ link head: 'FunctionExpand' arguments: { self }
]

{ #category : 'converting' }
WolframExpression >> graphics2D [

	^ (link head: 'Graphics' arguments: { self })
		  showPdfInsteadOfTeX;
		  yourself
]

{ #category : 'comparing' }
WolframExpression >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ head hash bitXor: arguments hash
]

{ #category : 'accessing' }
WolframExpression >> head [

	^ head
]

{ #category : 'accessing' }
WolframExpression >> head: anObject [

	head := anObject
]

{ #category : 'forms' }
WolframExpression >> holdForm [

	^ link head: 'HoldForm' arguments: { self }
]

{ #category : 'evaluating' }
WolframExpression >> info [

	^ self ? { (link head: 'Rule' arguments: #( LongForm True )) }
]

{ #category : 'evaluating' }
WolframExpression >> infoShort [

	^ self ? { (link head: 'Rule' arguments: #( LongForm False )) }
]

{ #category : 'initialization' }
WolframExpression >> initialize [

	super initialize.

	showPdfInsteadOfTeX := false
]

{ #category : 'testing' }
WolframExpression >> isWolframExpression [

	^ true
]

{ #category : 'accessing' }
WolframExpression >> link: anObject [

	link := anObject
]

{ #category : 'arithmetic' }
WolframExpression >> negated [

	^ (link head: 'Minus' arguments: { self }) simplify
]

{ #category : 'forms' }
WolframExpression >> outputForm [

	^ link head: 'OutputForm' arguments: { self }
]

{ #category : 'accessing' }
WolframExpression >> pattern: expr [

	^ link head: 'Pattern' arguments: {
			  self.
			  expr }
]

{ #category : 'printing' }
WolframExpression >> printOn: stream [

	stream << self holdForm toString
]

{ #category : 'arithmetic' }
WolframExpression >> printShowingDecimalPlaces: p [

	^ self asString
]

{ #category : 'evaluating' }
WolframExpression >> putOnLink: aLink [

	aLink putFunction: self head arity: self arguments size.

	self arguments do: [ :each | each putOnLink: aLink ]
]

{ #category : 'arithmetic' }
WolframExpression >> reciprocal [

	^ (link head: 'Divide' arguments: {
			   1.
			   self }) simplify
]

{ #category : 'accessing' }
WolframExpression >> showPdfInsteadOfTeX [

	showPdfInsteadOfTeX := true
]

{ #category : 'arithmetic' }
WolframExpression >> simplify [

	^ (link head: 'Simplify' arguments: { self }) value
]

{ #category : 'evaluating' }
WolframExpression >> standaloneLatexFooter [

	^ ' \)
\end{document}'
]

{ #category : 'evaluating' }
WolframExpression >> standaloneLatexPreamble [
	"https://tex.stackexchange.com/questions/353943/how-to-paste-a-mathematica-formula-to-the-latex-unicode-included"

	^ '\documentclass[12pt]{standalone}
\usepackage{mathtools}
\usepackage{concrete}
\usepackage{euler}
\usepackage{amssymb}
\usepackage[T1]{fontenc}
\usepackage{fontspec}
\newfontfamily{\mathematicamono}{MathematicaMono}
\ExplSyntaxOn
\NewDocumentCommand{\mmono}{m}
 {
  \text{\mathematicamono#1}
 }
\NewDocumentCommand{\unicode}{m}
 {
  \mmono { \symbol { \int_from_hex:n { #1 } } }
 }
\ExplSyntaxOff
\begin{document}
\(\displaystyle '
]

{ #category : 'forms' }
WolframExpression >> texForm [

	^ link head: 'TeXForm' arguments: { self }
]

{ #category : 'converting' }
WolframExpression >> textString [

	^ (link head: 'TextString' arguments: { self }) value
]

{ #category : 'converting' }
WolframExpression >> toString [

	^ (link head: 'ToString' arguments: { self }) value
]

{ #category : 'accessing' }
WolframExpression >> usageString [

	^ (link
		   head: 'ToString'
		   arguments: { (link head: 'Information' arguments: {
					    self.
					    'Usage' }) }) value
]

{ #category : 'evaluating' }
WolframExpression >> value [

	^ link
		  newPacket;
		  putFunction: 'EvaluatePacket' arity: 1;
		  putExpression: self;
		  endPacket;
		  flush;
		  evaluate
]

{ #category : 'visiting' }
WolframExpression >> valueWithArguments: args [

	^ link head: 'Construct' arguments: { self } , args
]

{ #category : 'evaluating' }
WolframExpression >> withStandaloneLaTeXStreamDo: block [

	^ String streamContents: [ :aStream |
		  aStream << self standaloneLatexPreamble.
		  block value: aStream.
		  aStream << self standaloneLatexFooter ]
]

{ #category : 'visiting' }
WolframExpression >> |-> exp [

	^ link head: 'Function' arguments: {
			  self.
			  exp }
]
