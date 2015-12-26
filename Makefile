CXX = g++ -std=c++14
CXXFLAGS = -O3 -Wall
INCLUDE = -I./include
ODIR = ./obj
SDIR = ./src
DIST = ./bin
SRCS = $(wildcard ./src/*.cpp)
OBJS = $(SRCS:./src/%.cpp=./obj/%.o)
TARGET = $(DIST)/a.out
EMXX = em++ -std=c++14
EMFLAGS = $(CXXFLAGS) -g3 --js-opts 1 --closure 2

all : $(TARGET)

$(TARGET): $(OBJS)
	if [ ! -d $(DIST) ]; then mkdir $(DIST); fi
	$(CXX) -o $@ $^

$(ODIR)/%.o: $(SDIR)/%.cpp
	if [ ! -d $(ODIR) ]; then mkdir $(ODIR); fi
	$(CXX) $(CXXFLAGS) $(INCLUDE) -o $@ -c $<

run:
	./bin/a.out

asmjs: $(TARGET).js

$(TARGET).js: $(SRCS)
	if [ ! -d $(DIST) ]; then mkdir $(DIST); fi
	$(EMXX) $(EMFLAGS) $(INCLUDE) -o $@ $^


.PHONY: clean
clean:
	rm -rf $(ODIR)/* $(DIST)/* $(LLVMDIR)/*
