function[]=coloredBar(bdata)
colors = ['b','g','r','y','c','m'];
hold on
sz=size(bdata,2);
for i = 1:sz
    bar(i,bdata(i),colors(i))
end