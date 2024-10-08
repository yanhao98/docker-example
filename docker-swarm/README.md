Docker Stack 是 Docker 中用于部署和管理一组相关服务的工具，主要用于在 Docker Swarm 模式下进行应用编排。以下是关于 Docker Stack 的必备知识点和常用命令：

### 必备知识点

1. **Docker Swarm 模式**：
   - Docker Stack 依赖于 Docker Swarm 模式，Swarm 是 Docker 自带的集群管理工具，允许你将多个 Docker 主机聚合成一个虚拟的 Docker 主机。
   - Swarm 模式下，可以将一组节点（Node）组织在一起，并将服务（Service）分配到这些节点上。

   #### 节点管理

   - 在 Swarm 集群中，节点分为管理节点（Manager Node）和工作节点（Worker Node）。管理节点负责集群的管理和服务的编排，工作节点负责运行实际的服务实例。

   - 添加节点到 Swarm 集群时，需要使用特定的加入 token：

     **获取工作节点加入 token**：

     ```bash
     docker swarm join-token worker
     ```

     **获取管理节点加入 token**：

     ```bash
     docker swarm join-token manager
     ```

     通过上述命令获取的 token 可以用于将新的 Docker 主机加入到 Swarm 集群中。例如，要将一个节点作为工作节点加入 Swarm，可以使用以下命令：

     ```bash
     docker swarm join --token <worker-token> <manager-ip>:<port>
     ```

2. **Stack**：

   - Stack 是一组相关联的服务集合，可以将其视为一个更高级别的应用单元。一个 Stack 通常包含多个服务，这些服务可以互相通信，构成完整的应用。

3. **Compose 文件**：
   - Docker Stack 通常使用 Docker Compose 文件 (`docker-compose.yml`) 来定义 Stack 中的服务、网络、卷等。这个文件描述了服务的配置，例如镜像、环境变量、端口映射等。

4. **服务（Service）**：
   - 服务是运行在 Swarm 中的一个容器的实例，Stack 中的每一个服务都可以由多个副本（Replica）组成，以实现负载均衡和高可用性。

5. **网络与存储**：
   - 在 Stack 中，可以定义多个服务共享的网络和存储卷，以确保不同服务之间的通信和数据持久化。
   - Overlay 网络：如果你的 Stack 中包含需要跨多个节点通信的服务，例如使用 Caddy 进行反向代理，你需要创建并使用 Docker 的 Overlay 网络。这种网络类型允许在多个 Docker 节点之间安全地连接服务，适用于分布式应用场景。


### 常用命令

1. **部署一个 Stack**：
   ```bash
   docker stack deploy -c <compose-file> <stack-name>
   ```
   - 该命令用于根据指定的 Compose 文件部署一个 Stack。例如：
     ```bash
     docker stack deploy --with-registry-auth -c docker-compose.yml my_stack
     ```

2. **查看已部署的 Stack**：
   ```bash
   docker stack ls
   ```
   - 列出当前 Swarm 集群中所有已部署的 Stack。

3. **查看 Stack 中的服务**：
   ```bash
   docker stack services <stack-name>
   ```
   - 列出指定 Stack 中的所有服务。例如：
     ```bash
     docker stack services my_stack
     ```

4. **查看 Stack 中的任务（Task）**：
   ```bash
   docker stack ps <stack-name>
   ```
   - 列出指定 Stack 中所有服务的运行任务，显示服务的实例分布和状态。

5. **移除一个 Stack**：
   ```bash
   docker stack rm <stack-name>
   ```
   - 删除指定的 Stack 及其所有相关服务。

6. **查看 Stack 中的服务日志**：
   ```bash
   docker service logs <service-name>
   ```
   - 查看 Stack 中某个服务的日志输出，例如：
     ```bash
     docker service logs my_stack_my_service
     docker service logs -f -n 10 global-nginx
     ```
   
7. **更新 Stack 中的服务**：
   ```bash
   docker service update --image <new-image> <service-name>
   ```
   - 更新 Stack 中某个服务的镜像版本，例如：
     ```bash
     docker service update --image my_image:latest my_stack_my_service
     ```

### 注意事项

- 部署 Stack 之前，需要确保 Docker 节点已经处于 Swarm 模式（`docker swarm init --advertise-addr <ip>:2377`），否则 Stack 将无法部署。
- Stack 中的服务与 Docker Compose 中的服务非常相似，但它们是为 Swarm 环境设计的，可以自动进行服务的伸缩和故障恢复。
- 如果你使用私有镜像仓库，记得使用 `--with-registry-auth` 选项，以确保所有 Swarm 节点能够成功拉取私有镜像。
- 如果使用 Caddy 作为反向代理，建议在 Stack 中定义一个 Overlay 网络，并确保 Caddy 和其他服务都在同一网络下，以保证跨节点的服务通信和负载均衡。
