#!/bin/lua5.4

local f0 = 2400 -- Hz
local Vmod = 600
local Vinf = 1200
local T = 1 / 600
local A = 1 -- TODO: why?
local Ns = 8
local dt = (1 / f0) / Ns
local q = 4
local m = 2

local t = {}
for i = 0, T, dt do
    t[#t + 1] = i
end

local Si1 = { A, A, -A, -A }
local Si2 = { A, -A, A, -A }

local S = {}
for _, tval in ipairs(t) do
    S[#S + 1] = Si1[1] * math.sqrt(2 / T) * math.cos(2 * math.pi * f0 * tval)
        + Si2[1] * math.sqrt(2 / T) * math.sin(2 * math.pi * f0 * tval)
end


local outfile = assert(io.open("data.csv", "w"))

for i = 1, #t do
    outfile:write(t[i] .. "," .. S[i], "\n")
end

outfile:close()
