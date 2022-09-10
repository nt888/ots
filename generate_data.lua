#!/bin/lua5.4

-- local Vmod = 600
-- local Vinf = 1200
-- local q = 4
-- local m = 2
local f0 = 2400 -- Hz
local T = 1 / 600
local A = 1 -- TODO: why?
local Ns = 32
local dt = (1 / f0) / Ns

local t = {}
for i = 0, T, dt do
    t[#t + 1] = i
end

local Si1 = { A, A, -A, -A }
local Si2 = { A, -A, A, -A }

local S = {}
for i = 1, #t do
    S[i] = {}
    for j = 1, #Si1 do
        S[i][j] = Si1[j] * math.sqrt(2 / T) * math.cos(2 * math.pi * f0 * t[i])
            + Si2[j] * math.sqrt(2 / T) * math.sin(2 * math.pi * f0 * t[i])
    end
end

local outfile = assert(io.open("data.csv", "w"))

for i = 1, #S do
    outfile:write(t[i], ",")
    for j = 1, #S[i] do
        outfile:write(S[i][j], ",") end
    outfile:write("\n")
end

outfile:close()
