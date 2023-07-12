Extension { #name : #String }

{ #category : #'*Wolfram' }
String >> putOnLink: link [

	^ link putSymbol: self asString
]
