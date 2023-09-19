Extension { #name : 'Fraction' }

{ #category : '*Wolfram' }
Fraction >> putOnLink: link [

	(link head: 'Rational' arguments: {
			 self numerator.
			 self denominator }) putOnLink: link
]
