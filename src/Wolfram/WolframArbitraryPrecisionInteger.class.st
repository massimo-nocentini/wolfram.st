Class {
	#name : #WolframArbitraryPrecisionInteger,
	#superclass : #WolframArbitraryPrecisionNumber,
	#category : #Wolfram
}

{ #category : #evaluating }
WolframArbitraryPrecisionInteger >> asTeXifiedShape [

	| liblua texContent texChunk |
	link
		putFunction: 'ToString' arity: 1;
		putFunction: 'TeXForm' arity: 1;
		putFunction: 'ToExpression' arity: 1;
		putExpression: self arguments first;
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

	^ (RSPdf compileTeX: texContent times: 1)
		  model: self;
		  yourself
]

{ #category : #evaluating }
WolframArbitraryPrecisionInteger >> putOnLink: alink [

	(alink head: 'FromDigits' arguments: self arguments) putOnLink: alink
]
