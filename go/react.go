package react

type reactor struct {
	cells []*cell
}

type cell struct {
	v         int
	r         *reactor
	cp        func() int
	callbacks map[Canceler]func(int)
}

type canceler struct {
	c *cell
}

func (c *canceler) Cancel() {
	delete(c.c.callbacks, c)
}

func (c *cell) Value() int {
	return c.v
}

func (c *cell) SetValue(value int) {
	if c.v == value {
		return
	}

	c.v = value
	c.r.update()
	for _, cb := range c.callbacks {
		cb(c.v)
	}
}

func (c *cell) AddCallback(callback func(int)) Canceler {
	cc := &canceler{c: c}
	c.callbacks[cc] = callback
	return cc
}

func New() Reactor {
	return &reactor{cells: []*cell{}}
}

func (r *reactor) CreateInput(initial int) InputCell {
	return &cell{
		v:         initial,
		r:         r,
		callbacks: map[Canceler]func(int){},
	}
}

func (r *reactor) CreateCompute1(dep Cell, compute func(int) int) ComputeCell {
	cp := func() int {
		return compute(dep.Value())
	}
	return r.createCompute(cp)
}

func (r *reactor) CreateCompute2(dep1, dep2 Cell, compute func(int, int) int) ComputeCell {
	cp := func() int {
		return compute(dep1.Value(), dep2.Value())
	}
	return r.createCompute(cp)
}

func (r *reactor) createCompute(cp func() int) ComputeCell {
	c := &cell{
		v:         cp(),
		r:         r,
		cp:        cp,
		callbacks: map[Canceler]func(int){},
	}
	r.cells = append(r.cells, c)
	return c
}

func (r *reactor) update() {
	for _, c := range r.cells {
		v := c.cp()
		if v != c.v {
			c.v = v
			for _, cb := range c.callbacks {
				cb(v)
			}
		}
	}
}
