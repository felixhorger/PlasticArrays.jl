
using Revise
using PlasticArrays

function test()
	for i = 1:10
		a = PlasticArray(8 * 500_000_000)
		@show sizeof(a.mem) * 1e-9
		b = mould(a, Float64, 500_000_000)
		GC.gc(true)
		b .= 0.0
	end
	GC.gc(true)
end
test()

GC.gc(true)

