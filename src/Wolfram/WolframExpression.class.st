Class {
	#name : #WolframExpression,
	#superclass : #Object,
	#instVars : [
		'head',
		'arguments',
		'link'
	],
	#category : #Wolfram
}

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
WolframExpression >> fullPangoPrintString [

	| liblua |
	link
		putFunction: 'ToString' arity: 1;
		putExpression: self;
		endPacket.

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

{ #category : #accessing }
WolframExpression >> head [

	^ head
]

{ #category : #accessing }
WolframExpression >> head: anObject [

	head := anObject
]

{ #category : #accessing }
WolframExpression >> link: anObject [

	link := anObject
]

{ #category : #evaluating }
WolframExpression >> putOnLink: aLink [

	aLink putFunction: self head arity: self arguments size.

	self arguments do: [ :each | each putOnLink: aLink ]
]

{ #category : #evaluating }
WolframExpression >> value [

	link
		putFunction: 'FullForm' arity: 1;
		putFunction: self head arity: self arguments size.

	self arguments do: #value.

	link endPacket
]
