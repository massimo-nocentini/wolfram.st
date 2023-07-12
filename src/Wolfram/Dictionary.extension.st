Extension { #name : #Dictionary }

{ #category : #'*Wolfram' }
Dictionary >> reifyWolframExpressionOnLink: link [

	| args head |
	head := self at: #head.

	args := (self at: #arguments) collect: [ :arg |
		        arg reifyWolframExpressionOnLink: link ].

	^ link head: head arguments: args
]
