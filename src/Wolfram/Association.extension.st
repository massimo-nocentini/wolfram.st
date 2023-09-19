Extension { #name : 'Association' }

{ #category : '*Wolfram' }
Association >> putOnLink: link [

	^ (link head: 'Rule' arguments: {
			   self key.
			   self value }) putOnLink: link
]
