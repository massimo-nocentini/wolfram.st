Class {
	#name : 'WolframArbitraryPrecisionNumber',
	#superclass : 'WolframExpression',
	#category : 'Wolfram',
	#package : 'Wolfram'
}

{ #category : 'evaluating' }
WolframArbitraryPrecisionNumber >> asTeXifiedShape [

	| liblua texContent texChunk shape |
	link
		endPacket;
		flush.

	liblua := LibLua uniqueInstance implementationPrimitive.

	texChunk := liblua withOpenedLibsStateDo: [ :L |
		            liblua on: L assertLUAOK: [
			            liblua
				            luaL_requiref: L name: 'wolfram';
				            on: L push: #wolfram;
				            lua: L get: -1 field: 'evaluate';
				            on: L push: link;
				            lua_pcall: L nargs: 1 nresults: liblua LUA_MULTRET ].

		            liblua on: L at: -1 ].

	texContent := self withStandaloneLaTeXStreamDo: [ :aStream |
		              aStream << texChunk ].

	shape := (PopplerPdf compileTeX: texContent times: 1) pages
		         ifEmpty: [ RSComposite new ]
		         ifNotEmpty: [ :pages | pages first ].

	^ shape
		  model: self;
		  yourself
]

{ #category : 'evaluating' }
WolframArbitraryPrecisionNumber >> putOnLink: alink [

	self subclassResponsibility
]
