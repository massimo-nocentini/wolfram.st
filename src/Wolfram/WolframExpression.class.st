Class {
	#name : #WolframExpression,
	#superclass : #Object,
	#instVars : [
		'head',
		'arguments',
		'link',
		'showPdfInsteadOfTeX'
	],
	#category : #Wolfram
}

{ #category : #visiting }
WolframExpression >> ! exp [

	^ (self valueWithArguments: { exp }) value
]

{ #category : #visiting }
WolframExpression >> & recvBlock [

	| f |
	f := link head: 'Function' arguments: { self }.

	^ recvBlock value: f
]

{ #category : #visiting }
WolframExpression >> && exp [

	^ link head: 'And' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> * exp [

	^ link head: 'Times' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> ** exp [

	^ link head: 'Power' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> + exp [

	^ link head: 'Plus' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> - exp [

	^ link head: 'Subtract' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> / exp [

	^ link head: 'Divide' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> /, exp [

	^ link head: 'ReplaceAll' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> /@ exp [

	^ link head: 'Map' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> <- exp [

	^ link head: 'Set' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> <-| exp [

	^ exp |-> self
]

{ #category : #visiting }
WolframExpression >> === exp [

	^ link head: 'Equal' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> => exp [

	^ link head: 'Implies' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> > exp [

	^ link head: 'Greater' arguments: {
			  self.
			  exp }
]

{ #category : #evaluating }
WolframExpression >> ? args [

	^ (link head: 'Information' arguments: { self } , args)
		  showPdfInsteadOfTeX;
		  yourself
]

{ #category : #visiting }
WolframExpression >> @ exp [

	^ link head: 'Indexed' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> @! exp [

	^ link head: 'Part' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> @* exp [

	^ link head: 'Composition' arguments: {
			  self.
			  exp }
]

{ #category : #visiting }
WolframExpression >> @@ args [

	^ link head: 'Apply' arguments: {
			  self.
			  args }
]

{ #category : #accessing }
WolframExpression >> _ [

	^ self pattern: link _
]

{ #category : #visiting }
WolframExpression >> acceptSlotDescriptorsVisitor: aVisitor [

	^ aVisitor visitWolframExpression: self
]

{ #category : #accessing }
WolframExpression >> arguments [

	^ arguments
]

{ #category : #accessing }
WolframExpression >> arguments: anObject [

	arguments := anObject
]

{ #category : #evaluating }
WolframExpression >> asDefaultShapeForWalker: walker descriptor: descriptor [

	^ showPdfInsteadOfTeX
		  ifTrue: [ self asExportedPdfShape ]
		  ifFalse: [ self asTeXifiedShape ]
]

{ #category : #evaluating }
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

	shape := (RSPdf new
		          fileReference: fullName asFileReference;
		          pages)
		         ifEmpty: [ RSComposite new ]
		         ifNotEmpty: [ :pages | pages first ].

	^ shape
		  model: self;
		  yourself
]

{ #category : #evaluating }
WolframExpression >> asMathematicaPrintString [

	| liblua |
	link
		putFunction: 'TextString' arity: 1;
		putFunction: 'HoldForm' arity: 1;
		putExpression: self;
		endPacket;
		flush.

	liblua := LibLua uniqueInstance.

	^ liblua withOpenedLibsStateDo: [ :L |
		  liblua on: L assertLUAOK: [
			  liblua
				  luaL_requiref: L name: 'wolfram';
				  on: L push: #wolfram;
				  lua_getfield: L at: -1 name: 'evaluate';
				  on: L push: link;
				  lua_pcall: L nargs: 1 nresults: liblua LUA_MULTRET ].

		  liblua on: L at: -1 ]
]

{ #category : #evaluating }
WolframExpression >> asTeXifiedShape [

	| liblua texContent texChunk shape |
	link
		putFunction: 'ToString' arity: 1;
		putFunction: 'TeXForm' arity: 1;
		putFunction: 'HoldForm' arity: 1;
		putExpression: self;
		endPacket;
		flush.

	liblua := LibLua uniqueInstance.

	texChunk := liblua withOpenedLibsStateDo: [ :L |
		            liblua on: L assertLUAOK: [
			            liblua
				            luaL_requiref: L name: 'wolfram';
				            on: L push: #wolfram;
				            lua_getfield: L at: -1 name: 'evaluate';
				            on: L push: link;
				            lua_pcall: L nargs: 1 nresults: liblua LUA_MULTRET ].

		            liblua on: L at: -1 ].

	texContent := self withStandaloneLaTeXStreamDo: [ :aStream |
		              aStream << texChunk ].

	shape := (RSPdf compileTeX: texContent times: 1) pages
		         ifEmpty: [ RSComposite new ]
		         ifNotEmpty: [ :pages | pages first ].

	^ shape
		  model: self;
		  yourself
]

{ #category : #'reflective operations' }
WolframExpression >> doesNotUnderstand: message [

	^ link
		  head: (message selector copyReplaceAll: ':' with: String empty)
		  arguments: (OrderedCollection new
				   add: self;
				   addAll: (message arguments
						    ifEmpty: [ Array empty ]
						    ifNotEmpty: [ :args | args first ]);
				   yourself)
]

{ #category : #evaluating }
WolframExpression >> evaluate [

	^ self -> self value
]

{ #category : #converting }
WolframExpression >> graphics2D [

	^ (link head: 'Graphics' arguments: { self })
		  showPdfInsteadOfTeX;
		  yourself
]

{ #category : #accessing }
WolframExpression >> head [

	^ head
]

{ #category : #accessing }
WolframExpression >> head: anObject [

	head := anObject
]

{ #category : #evaluating }
WolframExpression >> info [

	^ self ? { (link head: 'Rule' arguments: #( LongForm True )) }
]

{ #category : #evaluating }
WolframExpression >> infoShort [

	^ self ? { (link head: 'Rule' arguments: #( LongForm False )) }
]

{ #category : #initialization }
WolframExpression >> initialize [

	super initialize.

	showPdfInsteadOfTeX := false
]

{ #category : #testing }
WolframExpression >> isWolframExpression [

	^ true
]

{ #category : #accessing }
WolframExpression >> link: anObject [

	link := anObject
]

{ #category : #accessing }
WolframExpression >> pattern: expr [

	^ link head: 'Pattern' arguments: {
			  self.
			  expr }
]

{ #category : #evaluating }
WolframExpression >> printOn: stream [

	super printOn: stream.

	stream
		<< String space;
		<< '(';
		<< self asMathematicaPrintString;
		<< ')'
]

{ #category : #evaluating }
WolframExpression >> putOnLink: aLink [

	aLink putFunction: self head arity: self arguments size.

	self arguments do: [ :each | each putOnLink: aLink ]
]

{ #category : #accessing }
WolframExpression >> showPdfInsteadOfTeX [

	showPdfInsteadOfTeX := true
]

{ #category : #evaluating }
WolframExpression >> standaloneLatexFooter [

	^ ' \)
\end{document}'
]

{ #category : #evaluating }
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

{ #category : #accessing }
WolframExpression >> usageString [

	^ (link
		   head: 'ToString'
		   arguments: { (link head: 'Information' arguments: {
					    self.
					    'Usage' }) }) value
]

{ #category : #evaluating }
WolframExpression >> value [

	| liblua ret |
	link
		putFunction: 'EvaluatePacket' arity: 1;
		putExpression: self;
		endPacket;
		flush.

	liblua := LibLua uniqueInstance.

	ret := liblua withOpenedLibsStateDo: [ :L |
		       liblua on: L assertLUAOK: [
			       liblua
				       luaL_requiref: L name: 'wolfram';
				       on: L push: #wolfram;
				       lua_getfield: L at: -1 name: 'evaluate';
				       on: L push: link;
				       lua_pcall: L nargs: 1 nresults: liblua LUA_MULTRET ].

		       liblua on: L at: -1 ].

	^ ret reifyWolframExpressionOnLink: link
]

{ #category : #visiting }
WolframExpression >> valueWithArguments: args [

	^ link head: 'Construct' arguments: { self } , args
]

{ #category : #evaluating }
WolframExpression >> withStandaloneLaTeXStreamDo: block [

	^ String streamContents: [ :aStream |
		  aStream << self standaloneLatexPreamble.
		  block value: aStream.
		  aStream << self standaloneLatexFooter ]
]

{ #category : #visiting }
WolframExpression >> |-> exp [

	^ link head: 'Function' arguments: {
			  self.
			  exp }
]
