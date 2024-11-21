Extension { #name : 'Collection' }

{ #category : '*Wolfram' }
Collection >> binomial: p asWolframExpression: link [

	| n dict nw |
	n := self size.
	nw := n asWolframExpression: link.

	dict := Dictionary new: n.

	self withIndexDo: [ :each :i |
		| v |
		v := dict at: each ifAbsent: 0.
		dict
			at: each
			put: v + ((nw binomial: i) * (p ** i) * (1 - p ** (n - i))) ].

	^ dict
]
