﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ProjectTracker.Shared.Models.Project
{
    public record struct ProjectCreateRequest(
               string Name,
               string? Description,
               DateTime? StartDate,
               DateTime? EndDate
           );
}