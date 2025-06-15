local wezterm = require("wezterm")

local platform = require("utils.platform")()

local M = {}

M.GpuInfo = {
	has_discrete_gpu = false,
	has_integrated_gpu = false,
	DiscreteGpus = {},
	IntegratedGpus = {},
	Others = {},
}

local function choose_for_linux(GpuInfo)
	local best_adapter = nil
	if GpuInfo.has_discrete_gpu then
		for _, gpu in ipairs(GpuInfo.DiscreteGpus) do
			if gpu.backend == "Vulkan" then
				best_adapter = gpu
			end
		end
	elseif GpuInfo.has_integrated_gpu then
		for _, gpu in ipairs(GpuInfo.IntegratedGpus) do
			if gpu.backend == "Vulkan" then
				best_adapter = gpu
			end
		end
	end
	return best_adapter
end

local function choose_for_win(GpuInfo)
	local best_adapter = nil
	if GpuInfo.has_discrete_gpu then
		for _, gpu in ipairs(GpuInfo.DiscreteGpus) do
			if gpu.backend == "Dx12" then
				best_adapter = gpu
			end
		end
	elseif GpuInfo.has_integrated_gpu then
		for _, gpu in ipairs(GpuInfo.IntegratedGpus) do
			if gpu.backend == "Dx12" then
				best_adapter = gpu
			end
		end
	end
	return best_adapter
end

local function choose_for_mac(GpuInfo)
	local best_adapter = nil
	if GpuInfo.has_discrete_gpu then
		for _, gpu in ipairs(GpuInfo.DiscreteGpus) do
			if gpu.backend == "Metal" then
				best_adapter = gpu
			end
		end
	elseif GpuInfo.has_integrated_gpu then
		for _, gpu in ipairs(GpuInfo.IntegratedGpus) do
			if gpu.backend == "Metal" then
				best_adapter = gpu
			end
		end
	end
	return best_adapter
end

M.pick_gpu = function()
	local adapters = wezterm.gui.enumerate_gpus()

	for _, gpu in ipairs(adapters) do
		if gpu.device_type == "DiscreteGpu" then
			M.GpuInfo.has_discrete_gpu = true
			table.insert(M.GpuInfo.DiscreteGpus, gpu)
		elseif gpu.device_type == "IntegratedGpu" then
			M.GpuInfo.has_integrated_gpu = true
			table.insert(M.GpuInfo.IntegratedGpus, gpu)
		else
			table.insert(M.GpuInfo.Others, gpu)
		end
	end

	if platform.is_linux then
		return choose_for_linux(M.GpuInfo)
	end

	if platform.is_mac then
		return choose_for_mac(M.GpuInfo)
	end

	if platform.is_win then
		return choose_for_win(M.GpuInfo)
	end

	wezterm.log_warn("Can not find the best gpu backend", { platform = platform, GpuInfo = M.GpuInfo })
	return adapters[1]
end

return M
