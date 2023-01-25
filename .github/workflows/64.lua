function setBaseAddress(name, offset, value, flags, freeze)
	local addr = gg.getRangesList(name)[1]["start"] + offset
	local tb = {{["address"] = addr, ["value"] = value , ["flags"] = flags, ["freeze"] = freeze}}
	gg.setValues(tb)
	gg.addListItems(tb)
end
function search(t,Tab,Name,type,free)
    nm=os.clock()
    rt={}
    gg.setRanges(type)
    gg.clearResults()
    if tostring(t[1][1]):find("{") then
        gg.searchNumber(t[1][1][1].."~"..t[1][1][2], t[1][2], false, gg.SIGN_EQUAL, 0, -1)
     else
        gg.searchNumber(t[1][1], t[1][2], false, gg.SIGN_EQUAL, 0, -1)
    end
    local r = gg.getResults(99999999)
    if #r==0 then goto last end
    for it=2,#t do
        for i=1,#r do
            r[i].address=r[i].address+t[it][2]
            r[i].flags=t[it][3]
        end
        local rr=gg.getValues(r)
        tt={}
        for i=1,#rr do
            if tostring(t[it][1]):find("{") then
                if tonumber(rr[i].value)>=tonumber(t[it][1][1]) and tonumber(rr[i].value)<=tonumber(t[it][1][2]) then
                    ii=#tt+1
                    tt[ii]={}
                    tt[ii].address=rr[i].address-t[it][2]
                    tt[ii].flags=t[it][3]
                end
             else
                if tonumber(rr[i].value)==tonumber(t[it][1]) then
                    ii=#tt+1
                    tt[ii]={}
                    tt[ii].address=rr[i].address-t[it][2]
                    tt[ii].flags=t[it][3]
                end
            end
        end
        if #tt==0 then goto last end
        r=gg.getValues(tt)
        if it==#t then rt=r goto last end
    end
::last::
    if #rt>0 then
        for v=1,#Tab do
            tt={}
            for i=1,#rt do
                ii=#tt+1 tt[ii]={}
                tt[ii].address=rt[i].address+Tab[v][2]
                tt[ii].flags=Tab[v][3]
                tt[ii].value=Tab[v][1]
                if free or Tab[v][4] then
                    tt[i].freeze=true
                end
            end
            if free or Tab[v][4] then
                gg.addListItems(tt)
             else
                gg.setValues(tt)
            end
        end
        gg.toast(Name.."已开启，共修改"..#rt*#Tab.."个数值，耗时"..os.clock()-nm.."s")
        gg.setVisible(false)
        gg.clearResults()
     else gg.toast(Name.."开启失败")
    end
end

function Main()
local  Bc = gg.multiChoice({
  '透视',
  '范围',
  '吸附自瞄',
  '退出',
   })
   if Bc == nil then
  else
  if  Bc[1] ==   true then
    a()
  end
   if Bc[2] ==  true then
    b()
  end
  if Bc [3] == true then
    c()
  end
  if Bc[4] ==  true then
   Exit()
  end
  end
  XGCK = -1
  XGCK = -1
end


function a()
search({
    {"1050319515",4},
    {"2048",28,4},
    {"1008981770",68,4},
    {"1148846080",72,4},
},
{
    {"109800",28,4}, 
    },"透视",32 | 4)
end

function b()
search({
    {"1028711776",4},
    {"1041529569",4,4},
},
{
    {"2",0,16}, 
    },"加伤",4)
search({
    {"1110704128",4},
    {"1028443341",-4,4},
    {"1045220557",4,4},
},
{
    {"3.0",4,16},
    {"3.0",12,16},
    },"红名",4)
search({
    {"1008981770",4},
    {"1031127695",4,4},
},
{
    {"2",4,16}, 
    },"加伤",4)
end

function c()
search({
	{"452984790",4},
	{"-516948194",4,8},
	{"-509591552",4,24},
	{"-199128433",4,28},
},
{
	{"0",4,32},
	{"0",4,56},
	{"0",4,84},
	},"吸附自瞄",16384,false)
end

function Exit()
os.exit()
end

while true do
  if gg.isVisible(true) then
    XGCK = 1
    gg.setVisible(false)
  end
  gg.clearResults()
  if XGCK == 1 then
    Main()
  end
end








