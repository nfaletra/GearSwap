-- 3D Vector Class
-- By Autkast

-- Meta table
local vector_metatable = {}

-- Default constructor
local function new(x, y, z)
	return setmetatable({x = x or 0, y = y or 0, z = z or 0}, vector_metatable)
end

Vector3 = new

-- Component add
function vector_metatable:__add(other)
	return new(self.x + other.x, self.y + other.y, self.z + other.z)
end

-- Component subtract
function vector_metatable:__sub(other)
	return new(self.x - other.x, self.y - other.y, self.z - other.z)
end

-- Component multiply
function vector_metatable:__mult(other)
	if type(other) == "number" then
		return new(self.x * other, self.y * other, self.z * other)
	else
		return new(self.x * other.x, self.y * other.y, self.z * other.z)
	end
end

-- Component divide
function vector_metatable:__div(other)
	if type(other) == "number" then
		return new(self.x / other, self.y / other, self.z / other)
	else
		return new(self.x / other.x, self.y / other.y, self.z / other.z)
	end
end

-- Equality check
function vector_metatable:__eq(other)
	return self.x == other.x and self.y == other.y and self.z == other.z
end

-- Component negate
function vector_metatable:__unm()
	return new(-self.x, -self.y, -self.z)
end

-- ToString
function vector_metatable:__tostring()
	return "[X: "..self.x..", Y: "..self.y..", Z: "..self.z.."]"
end

-- Vector Add
function vector_metatable:Add(other)
	self = self + other
end

-- Vector Subtract
function vector_metatable:Sub(other)
	self = self - other
end

-- Component Multiply
function vector_metatable:Mul(n)
	self.x = self.x * n
	self.y = self.y * n
	self.z = self.z * n
end

-- Zero Vector
function vector_metatable:Zero()
	self.x = 0
	self.y = 0
	self.y = 0
	return self
end

-- Squared Size of Vector
function vector_metatable:SizeSq()
	return self.x * self.x + self.y * self.y * self.z * self.z
end

-- Size of Vector
function vector_metatable:Size()
	return SizeSq() ^ 0.5
end

-- Length of Vector (synonymous with size)
function vector_metatable:Length()
	return Size()
end

-- Normalize Vector
function vector_metatable:Normalize()
	local size = Size()
	self.x = self.x / size
	self.y = self.y / size
	self.z = self.z / size
	return new(self.x, self.y, self.z)
end

-- Get Normalized Vector
function vector_metatable:GetNormal()
	local size = Size()
	return new(self.x / size, self.y / size, self.z / size)
end

-- Dot Product
function vector_metatable:DotProduct(other)
	return self.x * other.x + self.y * other.y + self.z * other.z
end

-- Cross Product
function vector_metatable:CrossProduct(other)
	local vec = new()
	vec.x = self.y * other.z - other.y * self.z
	vec.y = self.z * other.x - other.z * self.x
	vec.z = self.x * other.y - other.x * self.y
	return vec
end