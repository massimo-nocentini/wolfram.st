Extension { #name : #False }

{ #category : #'*Wolfram' }
False >> putOnLink: link [

	^ (link head: 'False' arguments: {  }) putOnLink: link
]
