
module PlasticArrays
	
	export PlasticArray, mould

	struct PlasticArray
		nbytes::UInt64
		mem::Vector{UInt8}
		PlasticArray(nbytes::Integer) = new(nbytes, Vector{UInt8}(undef, nbytes))
	end

	function mould(a::PlasticArray, dtype::Type, shape::Tuple{Vararg{Integer}})
		@assert prod(shape) * sizeof(dtype) ≤ a.nbytes
		GC.@preserve a begin
			arr = unsafe_wrap(Array{dtype, length(shape)}, convert(Ptr{dtype}, pointer(a.mem)), shape; own=false)
			return arr
		end
	end
	mould(a::PlasticArray, dtype::Type, shape::Integer...) = mould(a, dtype, shape)

end
