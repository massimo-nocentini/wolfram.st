Extension { #name : 'ByteSymbol' }

{ #category : '*Wolfram' }
ByteSymbol >> asWolframExpression: aWolframLink [

	^ aWolframLink symbol: self
]
