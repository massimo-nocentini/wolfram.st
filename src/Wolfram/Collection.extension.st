Extension { #name : 'Collection' }

{ #category : '*Wolfram' }
Collection >> binomial: p wolfram: link [

	| n dict |
	n := self size asWolframExpression: link.

	dict := Dictionary new: self size.

	self withIndexDo: [ :each :i |
		| v |
		v := dict at: each ifAbsent: 0.
		dict
			at: each
			put: v + ((n binomial: i) * (p ** i) * (1 - p ** (n - i))) ].

	^ dict
]
