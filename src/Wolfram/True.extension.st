Extension { #name : #True }

{ #category : #'*Wolfram' }
True >> putOnLink: link [

	^ (link head: 'True' arguments: {  }) putOnLink: link
]
