__precompile__()
module EnvelopedArrays

import Base: tail, parent
export EnvelopedArray, envelope


struct EnvelopedArray{T<:Number,N,P} <: AbstractArray{T,N}
   envelope::T
   parent::P
   size::NTuple{N,Int}
end
function EnvelopedArray(envelope::T,parent::P) where {T<:Number,P}
   psize = size(parent)
   esize = (psize[1]+1,tail(psize)...)
   bigtype = promote_type(T,eltype(P))
   pp = convert.(bigtype,parent)
   EnvelopedArray{promote_type(T,eltype(P)),ndims(parent),typeof(pp)}(envelope,pp,esize)
end



# accessors and utilities
parent(A::EnvelopedArray) = A.parent
envelope(A::EnvelopedArray) = A.envelope
Base.size(A::EnvelopedArray) = A.size
Base.similar(A::EnvelopedArray{T,N,P}) where {T,N,P} = EnvelopedArray(A.envelope,zeros(T,size(parent(A))))


# Indexing functions
function Base.getindex(A::EnvelopedArray{T,N,P}, I::Vararg{Int,N}) where {T,N,P}
   if I[1] == 1
      return envelope(A)
   else
      return getindex(parent(A),I[1]-1,tail(I)...)
   end
end

function Base.getindex(A::EnvelopedArray{T,N,P}, i::Int) where {T,N,P}
   @assert i >= 1
   ci = ind2sub(size(A),i)
   if i == 1 || ci[1] == 1
      return envelope(A)
   else
      return getindex(parent(A),ci[1]-1,tail(ci)...)
   end
end

Base.IndexStyle(::Type{<:EnvelopedArray}) = IndexCartesian()





# for now, keep things immutable. to change envelope or parent, just create a new EnvelopedArray
# function Base.setindex(A::EnvelopedArray{T,N,P},x,i::Int) where {T,N,P}
   # @assert i >= 1
   # ci = ind2sub(size(A),i)
   # if i == 1 || ci[1] == 1
      # error("Cannot mutate envelope.")
   # else
      # setindex!(parent(A),x,ci[1]-1,tail(ci)...)
   # end
# end

end
