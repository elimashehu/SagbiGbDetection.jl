using Singular
using SagbiGbDetection

R1, (x, y) = Singular.polynomial_ring(Singular.QQ, ["x","y"])
G1 = [y^2-x, x^2-1]
weightVectorsRealizingGB(G1,R1)

S1, (x, y, z) = Singular.polynomial_ring(Singular.QQ, ["x","y","z"])
Q1 = [z, z*x, z*y, z*x*(x^2+y^2),z*y*(x^2+y^2)]
weightVectorsRealizingSAGBI(Q1,S1)

S2, (l, x, y, z) = Singular.polynomial_ring(Singular.QQ, ["l","x","y","z"])
Q2 = [z, z*x, z*y, z*x*(x^2+y^2),z*y*(x^2+y^2), l*z, l*z*x, l*z*y, l*z*x*(x^2+y^2), l*z*y*(x^2+y^2)]
weightVectorsRealizingSAGBI(Q2,S2)

S3, (s, b, c, d, e, x, y, z, u, v, w) = Singular.polynomial_ring(Singular.QQ, ["s","b", "c", "d", "e", "x", "y", "z", "u", "v", "w"])
Q3 = [s, s*b, s*c, s*d, -s*e, -s*x, -s*y, s*z, s*u, s*v, s*(x*b-c*e), s*(b*y-d*e), s*(c*y-d*x), s*(b*u-c*z), s*(w + v*(x*b-c*e) - u*(b*y-d*e) + z*(c*y-d*x))]
weightVectorsRealizingSAGBI(Q3,S3)

S4, (x, y) = Singular.polynomial_ring(Singular.QQ, ["x","y"])
Q4 = [x+y,x*y,x*y^2]
weightVectorsRealizingSAGBI(Q4,S4)

S5, (x, y, z) = Singular.polynomial_ring(Singular.QQ, ["x", "y", "z"])
Q5 = [x + y + z, x*y + x*z + y*z, x*y*z]
weightVectorsRealizingSAGBI(Q5,S5)

S6, (a,) = Singular.polynomial_ring(Singular.QQ, ["a"])
Q6 = [a^4+a^3,a^2+a,a^3 + a^2]
weightVectorsRealizingSAGBI(Q6,S6)

R7, (x, y, z) = Singular.polynomial_ring(Singular.QQ, ["x","y","z"])
G7 = [x^5 + y^3 + z^2 - 1, x^2 + y^2 + z - 1, x^6 + y^5 + z^3 - 1]
weightVectorsRealizingGB(G7,R7)
